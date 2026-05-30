{
  config,
  pkgs,
  me,
  ...
}:
{
  networking.networkmanager.enable = !config.networking.wireless.enable; # Disabled in iso

  # TODO: move to Avahi
  networking.hosts = {
    "192.168.42.1" = [
      "P520.local"
      "atuin.P520.local"
    ];
    "192.168.42.2" = [ "T420.local" ];
    "192.168.42.3" = [ "X201.local" ];
  };

  # For containers
  services.avahi = {
    enable = true;
    nssmdns4 = true;
  };

  # DNS
  services.dnsmasq = {
    enable = true;
    resolveLocalQueries = true;
    settings = {
      conf-dir = "/etc/dnsmasq.d/containers/,*.conf";
      listen-address = "127.0.0.1";
      bind-interfaces = true;
      domain-needed = true;
      bogus-priv = true;
    };
  };

  environment.etc."dnsmasq.d/containers/.keep".text = "";

  # Certificates
  environment.systemPackages = [
    pkgs.mkcert
    pkgs.nssTools
  ];

  security.pki.certificateFiles = [ ../secrets/rootCA/cert.pem ];

  age.secrets = {
    rootCA_cert = {
      file = ../secrets/rootCA/cert.age;
      path = "/home/${me.username}/.local/share/mkcert/rootCA.pem";
      owner = me.username;
      group = "users";
    };
    rootCA_cert_key = {
      file = ../secrets/rootCA/cert_key.age;
      path = "/home/${me.username}/.local/share/mkcert/rootCA-key.pem";
      owner = me.username;
      group = "users";
    };
  };

  persist.system = {
    directories = [
      "/etc/NetworkManager/system-connections"
    ];
  };
}
