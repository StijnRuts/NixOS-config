{
  outputs =
    { self, nixpkgs, ... }:
    {
      nixosConfigurations.X201 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hardware.nix
          self.nixosModules.disko
          self.nixosModules.locale
          self.nixosModules.networking
          self.nixosModules.nix
          self.nixosModules.user-stijn
          {
            # deviceType = "laptop";
            # deviceClass = "light";
            # disks.main = "ata-CT500BX500SSD1_2508E9AAEE57";
            # nixos.version = "26.05";
            # nixos.firstInstall = "26.05";
            user-stijn.enable = true;
            # administrators = [ "stijn" ];
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
