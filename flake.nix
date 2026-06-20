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
    niri = {
      inputs.nixpkgs.follows = "nixpkgs-current";
      url = "github:sodiboo/niri-flake";
    };
    nixpkgs-26-05.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-current.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
  outputs = inputs: inputs.flakegen ./flake.in.nix inputs;
}