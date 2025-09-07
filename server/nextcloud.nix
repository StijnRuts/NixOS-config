{
  config,
  pkgs,
  lib,
  ...
}:
{
  options.server.nextcloud.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable Nextcloud server";
  };

  config = {
    services = lib.mkIf config.server.nextcloud.enable {
      nextcloud = {
        enable = true;
        package = pkgs.nextcloud31;
        hostName = "nextcloud.localhost";
        settings = {
          trusted_domains = [ "nextcloud.P520.local" ];
          overwriteprotocol = "https";
        };
        https = true;
        database.createLocally = true;
        configureRedis = true;
        appstoreEnable = false;
        config = {
          dbtype = "pgsql";
          adminpassFile = config.age.secrets.nextcloud_admin_pass.path;
        };
      };

      nginx.virtualHosts."nextcloud.localhost".listen = [
        {
          addr = "127.0.0.1";
          port = 8882;
        }
      ];

      caddy = {
        enable = true;
        virtualHosts."nextcloud.P520.local".extraConfig = ''
          tls ${config.age.secrets.nextcloud_cert.path} ${config.age.secrets.nextcloud_cert_key.path}
          reverse_proxy nextcloud.localhost:8882
        '';
      };
    };

    age.secrets = lib.mkIf config.server.nextcloud.enable {
      nextcloud_admin_pass.file = ../secrets/nextcloud_admin_pass.age;
      nextcloud_cert = {
        file = ../secrets/nextcloud_cert.age;
        owner = "caddy";
        group = "caddy";
      };
      nextcloud_cert_key = {
        file = ../secrets/nextcloud_cert_key.age;
        owner = "caddy";
        group = "caddy";
      };
    };

    networking.firewall.allowedTCPPorts = lib.mkIf config.server.nextcloud.enable [
      80
      443
    ];

    persist.system = {
      directories = [
        {
          directory = "/var/lib/nextcloud";
          user = "nextcloud";
          group = "nextcloud";
          mode = "u=rwx,g=,o=";
        }
      ];
    };
  };
}
