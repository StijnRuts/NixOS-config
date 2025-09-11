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

  config = lib.mkIf config.server.nextcloud.enable {
    services = {
      nextcloud = {
        enable = true;
        package = pkgs.nextcloud31;
        hostName = "nextcloud.localhost";
        settings = {
          trusted_domains = [ "nextcloud.P520.local" ];
          trusted_proxies = [ "127.0.0.1" ];
          overwriteprotocol = "https";
          blacklisted_files = [ ]; # Don't forbid .htaccess
          forbidden_filenames = [ ]; # Don't forbid .htaccess
        };
        https = true;
        database.createLocally = true;
        configureRedis = true;
        appstoreEnable = false;
        config = {
          dbtype = "pgsql";
          adminpassFile = config.age.secrets.nextcloud_admin_pass.path;
        };
        phpOptions = {
          "opcache.interned_strings_buffer" = "16";
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

    systemd.services.nextcloud-custom-config = {
      path = [ config.services.nextcloud.occ ];
      script = ''
        nextcloud-occ maintenance:repair --include-expensive
        nextcloud-occ config:system:set maintenance_window_start --type=integer --value=1
      '';
      after = [ "nextcloud-setup.service" ];
      wantedBy = [ "multi-user.target" ];
    };

    age.secrets = {
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

    networking.firewall.allowedTCPPorts = [
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
