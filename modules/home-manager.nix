{
  inputs = {
    "home-manager-26-05" = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs-26-05";
    };
  };
  outputs = inputs: {
    nixosModules.home-manager =
      { config, lib, nixosVersion, ... }:
      {
        imports = [
          inputs."home-manager-${lib.replaceString "." "-" nixosVersion}".nixosModules.home-manager
        ];
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          backupFileExtension = "backup";
          overwriteBackup = true;
          extraSpecialArgs = { nixosConfig = config; };
        };
      };
    homeModules.home-manager =
      {
        config,
        lib,
        nixosConfig,
        ...
      }:
      {
        options.custom.home-manager.user = lib.mkOption {
          type = lib.types.str;
        };
        config =
          let
            username = config.custom.home-manager.user;
          in
          {
            home = {
              inherit username;
              homeDirectory = "/home/${username}";
              inherit (nixosConfig.system) stateVersion;
            };
            programs.home-manager.enable = true;
          };
      };
  };
}
