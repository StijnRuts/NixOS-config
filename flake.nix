{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }@args:
  {
    nixosConfigurations =
    {
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
