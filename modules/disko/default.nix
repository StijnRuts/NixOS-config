{
  inputs = {
    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = inputs: {
    nixosModules.disko =
      { lib, ... }:
      {
        imports = [
          inputs.disko.nixosModules.disko
          ./X201.nix # TODO
        ];
        options = {
          disks.main = lib.mkOption {
            type = lib.types.anything; # TODO
            default = { };
          };
        };
        config = {
          # TODO
        };
      };
  };
}
