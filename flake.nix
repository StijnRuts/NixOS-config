# Do not modify! This file is generated.
# One exception: If you use a different template than "flake.in.nix" set
#                its relative path through the first argument to inputs.flakegen.

{
  inputs = {
    disko = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/disko/latest";
    };
    flakegen.url = "github:jorsn/flakegen";
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-26.05";
  };
  outputs = inputs: inputs.flakegen ./flake.in.nix inputs;
}