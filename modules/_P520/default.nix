{
  outputs =
    { self, ... }:
    let
      h = {
        system = "x86_64-linux";
        hostname = "P520";
        nixosVersion = "26.05";
        installedAt = "24.05";
        disko = {
          main = "ata-CT500BX500SSD1_2508E9AAEE57";
          data = [
            "/dev/disk/by-id/ata-ST3000DM001-1ER166_Z500H9K9"
            "/dev/disk/by-id/ata-ST3000DM001-1ER166_Z5022VMX"
            "/dev/disk/by-id/ata-ST3000DM001-1ER166_Z500G9VD"
            "/dev/disk/by-id/ata-ST3000DM001-1ER166_Z5022W2R"
          ];
          raidLevel = 6;
          swapSize = "64G";
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
