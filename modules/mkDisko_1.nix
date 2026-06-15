let
  mkBoot = {
    size = "1M";
    type = "EF02";
  };

  mkESP = mountpoint: {
    size = "512M";
    type = "EF00";
    content = {
      type = "filesystem";
      format = "vfat";
      inherit mountpoint;
    };
  };

  mkBtrfsSubvolumes =
    swapsize: extraPersist:
    let
      base = {
        "/rootfs" = {
          mountpoint = "/";
        };
        "/nix" = {
          mountOptions = [
            "compress=zstd"
            "noatime"
          ];
          mountpoint = "/nix";
        };
        "/swap" = {
          mountpoint = "/.swapvol";
          swap.swapfile.size = swapsize;
        };
      };
    in
    base // extraPersist;

  mkLuksBtrfs = name: swapsize: extraPersist: {
    type = "luks";
    inherit name;
    content = {
      type = "btrfs";
      extraArgs = [ "-f" ];
      subvolumes = mkBtrfsSubvolumes swapsize extraPersist;
    };
  };

  mkDisk = device: content: {
    type = "disk";
    inherit device content;
  };

  mkMainDisk = device:
    {
      swapsize,
      legacyBIOS ? false,
      persistOnMain ? true,
    }:
    let
      extraPersist =
        if persistOnMain then
          {
            "/persist" = {
              mountOptions = [ "compress=zstd" ];
              mountpoint = "/persist";
            };
          }
        else
          { };
    in
    mkDisk device {
      type = "gpt";
      partitions = (mkIf legacyBIOS { boot = mkBoot; }) // {
        ESP = mkESP "/boot";
        root = {
          size = "100%";
          content = mkLuksBtrfs "encrypted_maindisk" swapsize extraPersist;
        };
      };
    };

  mkDataDisk = device: {
    type = "disk";
    inherit device;
    content = {
      type = "gpt";
      partitions.data = {
        size = "100%";
        content = {
          type = "luks";
          name = "encrypted_datadisk";
          content = {
            type = "btrfs";
            extraArgs = [ "-f" ];
            subvolumes = {
              "/persist" = {
                mountOptions = [ "compress=zstd" ];
                mountpoint = "/persist";
              };
            };
          };
        };
      };
    };
  };

  mkRaidDisk = name: device: {
    type = "disk";
    inherit device;
    content = {
      type = "gpt";
      partitions.mdadm = {
        size = "100%";
        content = {
          type = "mdraid";
          inherit name;
        };
      };
    };
  };

  mkRaid = name: { raidLevel }: {
    type = "mdadm";
    inherit level;
    content = {
      type = "gpt";
      partitions.primary = {
        size = "100%";
        content = {
          type = "luks";
          name = "encrypted_datadisk";
          content = {
            type = "btrfs";
            extraArgs = [ "-f" ];
            subvolumes = {
              "/persist" = {
                mountOptions = [ "compress=zstd" ];
                mountpoint = "/persist";
              };
            };
          };
        };
      };
    };
  };

  mkDisko =
    {
      main,
      data ? null,
      raidLevel ? 6,
      swapSize,
      legacyBIOS ? false
    }:
    let
      mainDisk = mkMainDisk main {
        inherit swapSize legacyBIOS;
        persistOnMain = data == null;
      };

      dataDisks =
        if data == null then
          {}
        else if builtins.isString data then
          (mkDataDisk data)
        else
          (mkDataDisks data)
          # RAID mode
          disks = lib.listToAttrs (map (d: {
            name = "datadisk_${lib.replaceStrings ["/"] ["_"] d}";
            value = mkRaidDisk "raid${toString raidLevel}" d;
          }) data);

      raidDisk =
        if data == null then
          {}
        else  {
          mdadm."raid${toString raidLevel}" = mkRaid "raid${toString raidLevel}" raidLevel;
        };
    in
    {
      disko.devices.disk = mainDisk // dataDisks // raidDisk;
    };
in
{
  outputs.lib.mkDisko = mkDisko;
}

/*
      main = "ata-CT500BX500SSD1_2508E9AAEE57";
      swapsize = "16G";
      separateBoot = true;
  or
      main = "/dev/disk/by-id/ata-Samsung_SSD_850_EVO_250GB_S2R6NB0HB68266K";
      data = "/dev/disk/by-id/ata-ST500LM021-1KJ152_W623Y2TK";
      swapsize = "16G";
  or
      main = "ata-CT500BX500SSD1_2508E9AAEE57";
      data = [
        "/dev/disk/by-id/ata-ST3000DM001-1ER166_Z500H9K9"
        "/dev/disk/by-id/ata-ST3000DM001-1ER166_Z5022VMX"
        "/dev/disk/by-id/ata-ST3000DM001-1ER166_Z500G9VD"
        "/dev/disk/by-id/ata-ST3000DM001-1ER166_Z5022W2R"
      ];
      raidLevel = 6;
      swapsize = "64G";
*/

/*
  {
    disko.devices = {
      disk = {
        maindisk = {
          type = "disk";
          device = "/dev/disk/by-id/ata-CT500BX500SSD1_2508E9AAEE57";
          content = {
            type = "gpt";
            partitions = {
              boot = {
                size = "1M";
                type = "EF02";
              };
              ESP = {
                size = "512M";
                type = "EF00";
                content = {
                  type = "filesystem";
                  format = "vfat";
                  mountpoint = "/boot";
                };
              };
              root = {
                size = "100%";
                content = {
                  type = "luks";
                  name = "encrypted_maindisk";
                  content = {
                    type = "btrfs";
                    extraArgs = [ "-f" ];
                    subvolumes = {
                      "/rootfs" = {
                        mountpoint = "/";
                      };
                      "/nix" = {
                        mountOptions = [
                          "compress=zstd"
                          "noatime"
                        ];
                        mountpoint = "/nix";
                      };
                      "/swap" = {
                        mountpoint = "/.swapvol";
                        swap = {
                          swapfile.size = "16G";
                        };
                      };
                      "/persist" = {
                        mountOptions = [ "compress=zstd" ];
                        mountpoint = "/persist";
                      };
                    };
                  };
                };
              };
            };
          };
        };
      };
    };
  }
  {
    disko.devices = {
      disk = {
        maindisk = {
          type = "disk";
          device = "/dev/disk/by-id/ata-Samsung_SSD_850_EVO_250GB_S2R6NB0HB68266K";
          content = {
            type = "gpt";
            partitions = {
              ESP = {
                size = "512M";
                type = "EF00";
                content = {
                  type = "filesystem";
                  format = "vfat";
                  mountpoint = "/boot";
                };
              };
              root = {
                size = "100%";
                content = {
                  type = "luks";
                  name = "encrypted_maindisk";
                  content = {
                    type = "btrfs";
                    extraArgs = [ "-f" ];
                    subvolumes = {
                      "/rootfs" = {
                        mountpoint = "/";
                      };
                      "/nix" = {
                        mountOptions = [
                          "compress=zstd"
                          "noatime"
                        ];
                        mountpoint = "/nix";
                      };
                      "/swap" = {
                        mountpoint = "/.swapvol";
                        swap = {
                          swapfile.size = "16G";
                        };
                      };
                    };
                  };
                };
              };
            };
          };
        };
        datadisk = {
          type = "disk";
          device = "/dev/disk/by-id/ata-ST500LM021-1KJ152_W623Y2TK";
          content = {
            type = "gpt";
            partitions = {
              data = {
                size = "100%";
                content = {
                  type = "luks";
                  name = "encrypted_datadisk";
                  content = {
                    type = "btrfs";
                    extraArgs = [ "-f" ];
                    subvolumes = {
                      "/persist" = {
                        mountOptions = [ "compress=zstd" ];
                        mountpoint = "/persist";
                      };
                    };
                  };
                };
              };
            };
          };
        };
      };
    };
  }
  {
    disko.devices = {
      disk = {
        maindisk = {
          type = "disk";
          device = "/dev/disk/by-id/nvme-SAMSUNG_MZVLB512HAJQ-000L7_S3TNNX0M314327";
          content = {
            type = "gpt";
            partitions = {
              ESP = {
                size = "512M";
                type = "EF00";
                content = {
                  type = "filesystem";
                  format = "vfat";
                  mountpoint = "/boot";
                };
              };
              root = {
                size = "100%";
                content = {
                  type = "luks";
                  name = "encrypted_maindisk";
                  content = {
                    type = "btrfs";
                    extraArgs = [ "-f" ];
                    subvolumes = {
                      "/rootfs" = {
                        mountpoint = "/";
                      };
                      "/nix" = {
                        mountOptions = [
                          "compress=zstd"
                          "noatime"
                        ];
                        mountpoint = "/nix";
                      };
                      "/swap" = {
                        mountpoint = "/.swapvol";
                        swap = {
                          swapfile.size = "64G";
                        };
                      };
                    };
                  };
                };
              };
            };
          };
        };
        datadisk_1 = {
          type = "disk";
          device = "/dev/disk/by-id/ata-ST3000DM001-1ER166_Z500H9K9";
          content = {
            type = "gpt";
            partitions = {
              mdadm = {
                size = "100%";
                content = {
                  type = "mdraid";
                  name = "raid6";
                };
              };
            };
          };
        };
        datadisk_2 = {
          type = "disk";
          device = "/dev/disk/by-id/ata-ST3000DM001-1ER166_Z5022VMX";
          content = {
            type = "gpt";
            partitions = {
              mdadm = {
                size = "100%";
                content = {
                  type = "mdraid";
                  name = "raid6";
                };
              };
            };
          };
        };
        datadisk_3 = {
          type = "disk";
          device = "/dev/disk/by-id/ata-ST3000DM001-1ER166_Z500G9VD";
          content = {
            type = "gpt";
            partitions = {
              mdadm = {
                size = "100%";
                content = {
                  type = "mdraid";
                  name = "raid6";
                };
              };
            };
          };
        };
        datadisk_4 = {
          type = "disk";
          device = "/dev/disk/by-id/ata-ST3000DM001-1ER166_Z5022W2R";
          content = {
            type = "gpt";
            partitions = {
              mdadm = {
                size = "100%";
                content = {
                  type = "mdraid";
                  name = "raid6";
                };
              };
            };
          };
        };
      };
      mdadm = {
        raid6 = {
          type = "mdadm";
          level = 6;
          content = {
            type = "gpt";
            partitions.primary = {
              size = "100%";
              content = {
                type = "luks";
                name = "encrypted_datadisk";
                content = {
                  type = "btrfs";
                  extraArgs = [ "-f" ];
                  subvolumes = {
                    "/persist" = {
                      mountOptions = [ "compress=zstd" ];
                      mountpoint = "/persist";
                    };
                  };
                };
              };
            };
          };
        };
      };
    };
  }
*/
