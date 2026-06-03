{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkIf config.apps.utilities.enable {
    virtualisation.podman = {
      enable = true;
      # dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
      extraPackages = [ pkgs.podman-compose ];
    };

    environment.systemPackages = [
      pkgs.podman-desktop
      pkgs.podman-tui
    ];

    persist.home = {
      directories = [
        ".local/share/containers"
      ];
    };
  };
}
