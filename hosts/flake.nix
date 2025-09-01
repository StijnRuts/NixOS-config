{
  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-25.05";
    };
    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = inputs: {
    modules = {
      nixos = [
        inputs.disko.nixosModules.disko
      ];
    };

    X201 = import ./X201;
    T420 = import ./T420;
    P520 = import ./P520;
  };
}
