{
  config,
  lib,
  pkgs-unstable,
  ...
}:
{
  environment.systemPackages = lib.mkIf config.apps.utilities.enable [
    pkgs-unstable.devenv
  ];

  persist.home = {
    directories = [
      ".local/share/devenv"
    ];
  };
}
