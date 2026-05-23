_: {
  inputs = {
    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = inputs: {
    nixosModules = [
      inputs.disko.nixosModules.disko
    ];
  };
}
