{ config, pkgs, ... }:
{
  services.atuin = {
    enable = true;
    host = "127.0.0.1";
    port = 1888;
    openRegistration = true;
  };

  services.caddy = {
    enable = true;
    virtualHosts."atuin.P520.local".extraConfig = ''
      tls ${config.age.secrets.atuin_cert.path} ${config.age.secrets.atuin_cert_key.path}
      reverse_proxy http://127.0.0.1:1888
    '';
  };

  networking.firewall.allowedTCPPorts = [
    80
    443
  ];

  environment.persistence."/persist" = {
    directories = [
      "/run/postgresql"
    ];
  };
}
