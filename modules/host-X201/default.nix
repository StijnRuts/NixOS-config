{
  hosts.X201 = {
    system = "x84_64-linux";
    hostConfig =
      { self, ... }:
      {
        imports = [
          ./hardware.nix
          self.nixosModules.disko
          self.nixosModules.locale
          self.nixosModules.networking
          self.nixosModules.nix
          self.nixosModules.users.stijn
        ];
        # deviceType = "laptop";
        # deviceClass = "light";
        # disks.main = "ata-CT500BX500SSD1_2508E9AAEE57";
        # nixos.version = "26.05";
        # nixos.firstInstall = "26.05";
        users.stijn.enabled = true;
        # administrators = [ "stijn" ];
      };
  };
}
