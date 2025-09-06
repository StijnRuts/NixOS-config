{ config, lib, ... }:
{
  options.server.atuin.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable Nextcloud server";
  };

  config = {
    services.atuin = {
      inherit (config.server.atuin) enable;
      host = "127.0.0.1";
      port = 1888;
      openRegistration = false;
    };

    services.caddy = {
      inherit (config.server.atuin) enable;
      virtualHosts."atuin.P520.local".extraConfig = ''
        tls ${config.age.secrets.atuin_cert.path} ${config.age.secrets.atuin_cert_key.path}
        reverse_proxy http://127.0.0.1:1888
      '';
    };

    age.secrets = {
      atuin_cert = {
        file = ../secrets/atuin_cert.age;
        owner = "caddy";
        group = "caddy";
      };
      atuin_cert_key = {
        file = ../secrets/atuin_cert_key.age;
        owner = "caddy";
        group = "caddy";
      };
    };

    networking.firewall.allowedTCPPorts = lib.mkIf config.server.atuin.enable [
      80
      443
    ];

    persist.system = {
      directories = [
        "/var/lib/postgresql"
      ];
    };
  };
}
