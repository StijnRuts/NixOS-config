{ config, lib, ... }:
{
  config = lib.mkIf config.apps.utilities.enable {
    services.flatpak.enable = true;

    persist.system = {
      directories = [
        "/var/lib/flatpak"
      ];
    };
    persist.home = {
      directories = [
        ".local/share/flatpak"
      ];
    };
  };
}
