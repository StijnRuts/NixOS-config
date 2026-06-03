{ lib, ... }: {
  options = {
    inputs = lib.mkOption {
      type = lib.types.anything;
      default = {};
      description = "Lorem";
    };
    nixosConfigurations = lib.mkOption {
      type = lib.types.anything;
      default = _: {};
      description = "Ipsum";
    };
  };
  config = {
    inputs = {
      nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-26.05";
      disko = {
        url = "github:nix-community/disko/latest";
        inputs.nixpkgs.follows = "nixpkgs";
      };
    };
    nixosConfigurations.X201 = inputs: {
      system = "x86_64-linux";
      modules = [
        inputs.disko.nixosModules.disko
        ./disko.nix
        ./configuration.nix
        ./hardware-configuration.nix
      ];
    };
  };
}
