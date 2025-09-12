{ config, lib, me, ... }:
{
  services.tarsnap = {
    enable = true;
    archives = {
      nextcloud = lib.mkIf config.server.nextcloud.enable {
        keyfile = config.age.secrets.tarsnap_nextcloud_key.path;
        # tarsnap-keymgmt --outkeyfile tarsnap-nextcloud.key -w tarsnap.key
        period = "daily";
        checkpointBytes = null;
        directories = lib.map (dir: "/var/lib/nextcloud/data/${me.name}/files/${dir}") [
          "Documents"
          # "Downloads" # Don't backup Downloads
          "Music"
          "NixOS"
          "Pictures"
          "Projects"
          "Public"
          "Templates"
          "Videos"
        ];
      };
    };
  };

  age.secrets.tarsnap_nextcloud_key.file = ../secrets/tarsnap/nextcloud.age;

  persist.system = {
    directories = [
      "/var/cache/tarsnap"
    ];
  };
}
