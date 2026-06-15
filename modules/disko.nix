{
  inputs = {
    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs-current";
    };
  };
  outputs = inputs: {
    nixosModules.disko = {
      imports = [
        inputs.disko.nixosModules.disko
      ];
    };
  };
}
