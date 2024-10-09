{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = { self, nixpkgs, home-manager, ... }@args: {
    nixosConfigurations =
      let commonModules = [
        ./configuration-system.nix
        home-manager.nixosModules.home-manager {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.stijn = import ./configuration-home.nix;
          };
        }
      ];
      in {
        X201 = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = args;
          modules = commonModules ++ [ ./hardware/X201.nix ];
        };
        T420 = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = args;
          modules = commonModules ++ [ ./hardware/T420.nix ];
        };
      };
  };
}
