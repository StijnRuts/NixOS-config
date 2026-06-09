{
  outputs = inputs: {
    nixosConfigurations.X201 = inputs.nixpkgs.lib.nixosSystem {
      system = "x84_64-linux";
      modules = [
        ./hardware.nix
        inputs.self.nixosModules.disko
        inputs.self.nixosModules.locale
        inputs.self.nixosModules.networking
        inputs.self.nixosModules.nix
        inputs.self.nixosModules.user-stijn
        {
          # deviceType = "laptop";
          # deviceClass = "light";
          # disks.main = "ata-CT500BX500SSD1_2508E9AAEE57";
          # nixos.version = "26.05";
          # nixos.firstInstall = "26.05";
          user-stijn.enabled = true;
          # administrators = [ "stijn" ];
        }
      ];
    };
  };
}
