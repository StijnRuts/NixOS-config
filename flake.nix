{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
  };
  outputs = { self, nixpkgs, ... }@args: {
    nixosConfigurations = {
      X201 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = args;
        modules = [
          ./hardware/X201.nix
          ./configuration.nix
        ];
      };
      T420 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = args;
        modules = [
          ./hardware/T420.nix
          ./configuration.nix
        ];
      };
    };
  };
}
