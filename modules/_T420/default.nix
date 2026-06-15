{
  outputs =
    { self, ... }:
    let
      h = {
        system = "x86_64-linux";
        hostname = "T420";
        nixosVersion = "26.05";
        installedAt = "24.05";
        disko = {
          main = "/dev/disk/by-id/ata-Samsung_SSD_850_EVO_250GB_S2R6NB0HB68266K";
          data = "/dev/disk/by-id/ata-ST500LM021-1KJ152_W623Y2TK";
          swapSize = "16G";
        };
        config = {
          imports = [
            ./hardware.nix
            self.nixosModules.admins
            self.nixosModules.locale
            self.nixosModules.networking
            self.nixosModules.nix
            self.nixosModules.stijn
          ];
          custom = {
            # TODO
            #device = {
            #  type = "laptop";
            #  class = "light";
            #};
            stijn.enable = true;
            admins = [ "stijn" ];
          };
        };
      };
      host = self.lib.mkHost h;
    in
    {
      nixosConfigurations.${h.hostname} = host.nixosConfiguration;
      diskoConfigurations.${h.hostname} = host.diskoConfiguration;
    };
}
