{
  config,
  pkgs,
  me,
  ...
}:
{
  networking.networkmanager.enable = true;

  networking.hosts = {
    "192.168.42.1" = [
      "P520.local"
      "atuin.P520.local"
    ];
    "192.168.42.2" = [ "T420.local" ];
    "192.168.42.3" = [ "X201.local" ];
  };

  environment.systemPackages = with pkgs; [
    mkcert
    nssTools
  ];

  security.pki.certificateFiles = [ ../secrets/rootCA.pem ];

  environment.persistence."/persist" = {
    directories = [
      "/etc/NetworkManager/system-connections"
    ];
  };
}
