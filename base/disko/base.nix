{
  inputs.disko = {
    url = "github:nix-community/disko/latest";
    inputs.nixpkgs.follows = "nixpkgs";
  };
  nixosModules = inputs: [
    inputs.disko.nixosModules.disko
  ];
}
