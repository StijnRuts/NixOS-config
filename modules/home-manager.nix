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
        host,
        lib,
        ...
      }:
      {
        imports = [
          inputs."home-manager-${lib.replaceString "." "-" host.nixosVersion}".nixosModules.home-manager
        ];
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
    homeModules.home-manager =
      {
        nixosConfig,
        user,
        ...
      }:
      {
        config =
          {
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
