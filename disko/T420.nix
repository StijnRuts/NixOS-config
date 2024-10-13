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
                        swapfile.size = "8G";
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
