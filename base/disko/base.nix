{
  inputs.disko = {
    url = "github:nix-community/disko/latest";
    inputs.nixpkgs.follows = "nixpkgs";
  };
  nixosModules = inputs: [
    inputs.disko.nixosModules.disko
    (
      { config, lib, ... }:
      {
        # TODO refactor
        options.base.disko.profile = lib.mkOption {
          type = lib.types.enum [
            "X201"
            "T420"
            "P520"
          ];
          description = "Sets your disk layout profile";
        };

        config = lib.mkMerge [
          (lib.mkIf (config.base.disko.profile == "X201") (import ./X201.nix))
          (lib.mkIf (config.base.disko.profile == "T420") (import ./T420.nix))
          (lib.mkIf (config.base.disko.profile == "P520") (import ./P520.nix))
        ];
      }
    )
  ];
}
