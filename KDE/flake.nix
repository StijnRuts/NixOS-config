{
  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-25.05";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };
  outputs = inputs: {
    modules = {
      nixos = [
        ./desktop.nix
        ./sddm.nix
      ];
      home = [
        inputs.plasma-manager.homeModules.plasma-manager
        ./plasma.nix
        ./dolphin.nix
        ./konsole.nix
      ];
    };
  };
}
