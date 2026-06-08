{
  config,
  lib,
  devenv-pkgs,
  ...
}:
{
  config = lib.mkIf config.apps.utilities.enable {
    environment.systemPackages = [
      devenv-pkgs.devenv
    ];

    persist.home = {
      directories = [
        ".local/share/devenv"
      ];
    };
  };
}
