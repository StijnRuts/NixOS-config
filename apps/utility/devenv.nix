{
  config,
  lib,
  pkgs-unstable,
  ...
}:
{
  config = lib.mkIf config.apps.utilities.enable {
    environment.systemPackages = [
      pkgs-unstable.devenv
    ];

    persist.home = {
      directories = [
        ".local/share/devenv"
      ];
    };
  };
}
