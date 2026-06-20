{
  outputs =
    { self, ... }:
    let
      h = {
        host = {
          system = "x86_64-linux";
          hostname = "X201";
          nixosVersion = "26.05";
          installedAt = "26.05";
        };
        disko = {
          main = "/dev/disk/by-id/ata-CT500BX500SSD1_2508E9AAEE57";
          swapSize = "16G";
          legacyBIOS = true;
        };
        config = {
          imports = [
            ./hardware.nix
            self.nixosModules.admins
            self.nixosModules.locale
            self.nixosModules.networking
            self.nixosModules.nix
            self.nixosModules.stijn
            self.nixosModules.greetd
          ];
          custom = {
            # TODO
            #device = {
            #  type = "laptop";
            #  class = "light";
            #};
            greetd.enable = true;
            stijn.enable = true;
            admins = [ "stijn" ];
          };
        };
      };
      host = self.lib.mkHost h;
    in
    {
      nixosConfigurations.${h.host.hostname} = host.nixosConfiguration;
      diskoConfigurations.${h.host.hostname} = host.diskoConfiguration;
    };
}
