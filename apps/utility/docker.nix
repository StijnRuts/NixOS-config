{
  config,
  lib,
  pkgs,
  ...
}:
{
  virtualisation.docker = {
    inherit (config.apps.utilities) enable;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

  environment.systemPackages = lib.mkIf config.apps.utilities.enable [
    pkgs.lazydocker
  ];

  persist.home = {
    directories = [
      ".local/share/docker"
    ];
  };
  persist.system = {
    directories = [
      "/var/lib/docker"
    ];
  };
}
