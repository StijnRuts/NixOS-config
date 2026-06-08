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
