{
  outputs.lib.mkDisko =
    d:
    let
      ### DISKS ##############################

      mainDisk = {
        maindisk = {
          type = "disk";
          device = d.main;
          content = {
            type = "gpt";
            partitions = mainPartitions;
          };
        };
      };

      ### PARTITIONS #########################

      mainPartitions = bootPartition // espPartition // rootPartition;

      bootPartition =
        if d.legacyBIOS then
          {
            boot = {
              size = "1M";
              type = "EF02";
            };
          }
        else
          { };

      espPartition = {
        ESP = {
          size = "512M";
          type = "EF00";
          content = {
            type = "filesystem";
            format = "vfat";
            mountpoint = "/boot";
          };
        };
      };

      rootPartition = {
        root = {
          size = "100%";
          content = {
            type = "luks";
            name = "encrypted_maindisk";
            content = {
              type = "btrfs";
              extraArgs = [ "-f" ];
              subvolumes = mainSubvolumes;
            };
          };
        };
      };

      ### PARTITIONS #########################

      mainSubvolumes = rootSubvolume // nixSubvolume // swapSubvolume // persistSubvolume;

      rootSubvolume = {
        "/rootfs" = {
          mountpoint = "/";
        };
      };

      nixSubvolume = {
        "/nix" = {
          mountOptions = [
            "compress=zstd"
            "noatime"
          ];
          mountpoint = "/nix";
        };
      };

      swapSubvolume = {
        "/swap" = {
          mountpoint = "/.swapvol";
          swap = {
            swapfile.size = d.swapSize;
          };
        };
      };

      persistSubvolume = {
        "/persist" = {
          mountOptions = [ "compress=zstd" ];
          mountpoint = "/persist";
        };
      };
    in
    {
      disko.devices.disk = mainDisk;
    };
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
  # TODO
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
