{
  inputs = {
    "home-manager-26-05" = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs-26-05";
    };
  };
  outputs = inputs: {
    nixosModules.home-manager =
      {
        config,
        host,
        lib,
        ...
      }:
      {
        imports = [
          inputs."home-manager-${lib.replaceString "." "-" host.nixosVersion}".nixosModules.home-manager
        ];
        options.custom.home-manager.enable = lib.mkEnableOption "home-manager";
        config = lib.mkIf config.custom.home-manager.enable {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            backupFileExtension = "backup";
            overwriteBackup = true;
            extraSpecialArgs = {
              inherit host;
            };
          };
        };
      };
    homeModules.home-manager =
      {
        config,
        lib,
        nixosConfig,
        user,
        ...
      }:
      {
        options.custom.home-manager.enable = lib.mkEnableOption "home-manager";
        config = lib.mkIf config.custom.home-manager.enable {
          home = {
            inherit (user) username;
            homeDirectory = "/home/${user.username}";
            inherit (nixosConfig.system) stateVersion;
          };
          programs.home-manager.enable = true;
        };
      };
  };
}
