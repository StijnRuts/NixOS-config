{
  config,
  pkgs,
  lib,
  me,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    devenv
    caddy
    mkcert # For generating certificates
    nssTools # For installing the root certificate
  ];

  security.wrappers.caddy = {
    source = "${pkgs.caddy}/bin/caddy";
    capabilities = "cap_net_bind_service=+ep";
    owner = "root";
    group = "root";
  };

  system.activationScripts.mkcertInstall.text = ''
    mkcert -install
    caddy trust
  '';

  environment.persistence."/persist" = {
    users.${me.username} = {
      directories = [
        ".config/caddy"
        ".local/share/caddy"
      ];
    };
  };
}
