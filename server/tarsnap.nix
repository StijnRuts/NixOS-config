{
  config,
  lib,
  me,
  ...
}:
{
  options.server.tarsnap.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable Tarsnap backups";
  };

  config = lib.mkIf config.server.tarsnap.enable {
    services.tarsnap = {
      enable = true;
      archives = {
        homedirs = {
          keyfile = config.age.secrets.tarsnap_homedirs_key.path;
          # tarsnap-keymgmt --outkeyfile tarsnap-homedirs.key -w tarsnap.key
          period = "daily";
          checkpointBytes = null;
          directories = [
            "/home/${me.username}/Documents"
            # "/home/${me.username}/Downloads" # Don't backup Downloads
            "/home/${me.username}/Music"
            "/home/${me.username}/NixOS"
            "/home/${me.username}/Pictures"
            "/home/${me.username}/Projects"
            "/home/${me.username}/Public"
            "/home/${me.username}/Templates"
            "/home/${me.username}/Videos"
          ];
        };
      };
    };

    age.secrets.tarsnap_homedirs_key.file = ../secrets/tarsnap/homedirs.age;

    persist.system = {
      directories = [
        "/var/cache/tarsnap"
      ];
    };
  };
}
