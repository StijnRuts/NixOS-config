{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    impermanence.url = "github:nix-community/impermanence";
    plasma-manager.url = "github:nix-community/plasma-manager";
    plasma-manager.inputs.nixpkgs.follows = "nixpkgs";
    plasma-manager.inputs.home-manager.follows = "home-manager";
  };

  outputs = { self, nixpkgs, home-manager, impermanence, plasma-manager, ... }@args:
  {
    nixosConfigurations =
    {
      T420 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = args;
        modules = [
          ./hardware/T420.nix
          ./configuration-system.nix
          impermanence.nixosModules.impermanence
          ./impermanence.nix

          home-manager.nixosModules.home-manager {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "backup";
              sharedModules = [ plasma-manager.homeManagerModules.plasma-manager ];
              users.stijn = import ./configuration-home.nix;
            };
          }
        ];
      };
    };
  };
}
