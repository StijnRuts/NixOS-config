{
  outputs =
    { self, nixpkgs-current, ... }:
    {
      nixosConfigurations.X201 = nixpkgs-current.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          system = "x86_64-linux";
          nixosVersion = "26.05";
          installedAt = "26.05";
        };
        modules = [
          ./hardware.nix
          self.nixosModules.disko
          self.nixosModules.locale
          self.nixosModules.networking
          self.nixosModules.nix
          self.nixosModules.stijn
          self.nixosModules.admins
          {
            # TODO
            custom = {
              # deviceType = "laptop";
              # deviceClass = "light";
              # disks.main = "ata-CT500BX500SSD1_2508E9AAEE57";
              stijn.enable = true;
              admins = [ "stijn" ];
            };
          }
        ];
      };

      diskoConfigurations.X201 = {
        disko = {
          # TODO
          #devices = {
          #  disk = {
          #    my-disk = {
          #      content = {
          #        partitions = {
          #          ESP = {
          #            content = {
          #              format = "vfat";
          #              mountOptions = [
          #                "umask=0077"
          #              ];
          #              mountpoint = "/boot";
          #              type = "filesystem";
          #            };
          #            size = "500M";
          #            type = "EF00";
          #          };
          #          root = {
          #            content = {
          #              format = "ext4";
          #              mountpoint = "/";
          #              type = "filesystem";
          #            };
          #            size = "100%";
          #          };
          #        };
          #        type = "gpt";
          #      };
          #      device = "/dev/sda";
          #      type = "disk";
          #    };
          #  };
          #};
        };
      };
    };
}
