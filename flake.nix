# Do not modify! This file is generated.
# One exception: If you use a different template than "flake.in.nix" set
#                its relative path through the first argument to inputs.flakegen.

{
  inputs = {
    disko = {
      inputs.nixpkgs.follows = "nixpkgs-current";
      url = "github:nix-community/disko/latest";
    };
    flakegen.url = "github:jorsn/flakegen";
    home-manager-26-05 = {
      inputs.nixpkgs.follows = "nixpkgs-26-05";
      url = "github:nix-community/home-manager/release-26.05";
    };
    home-manager-current = {
      inputs.nixpkgs.follows = "nixpkgs-26-05";
      url = "github:nix-community/home-manager/release-26.05";
    };
    home-manager-droid = {
      inputs.nixpkgs.follows = "nixpkgs-droid";
      url = "github:nix-community/home-manager/release-24.05";
    };
    impermanence = {
      inputs = {
        home-manager.follows = "home-manager-current";
        nixpkgs.follows = "nixpkgs-current";
      };
      url = "github:nix-community/impermanence";
    };
    niri = {
      inputs.nixpkgs.follows = "nixpkgs-current";
      url = "github:sodiboo/niri-flake";
    };
    nix-on-droid = {
      inputs = {
        home-manager.follows = "home-manager-droid";
        nixpkgs.follows = "nixpkgs-droid";
      };
      url = "github:nix-community/nix-on-droid/release-24.05";
    };
    nixpkgs-26-05.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-current.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-droid.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
  outputs = inputs: inputs.flakegen ./flake.in.nix inputs;
}