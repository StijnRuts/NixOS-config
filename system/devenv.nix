{
  config,
  pkgs,
  pkgs-unstable,
  lib,
  me,
  ...
}:
{
  environment.systemPackages = [
    pkgs-unstable.devenv
    # caddy
    # kcert # For generating certificates
    # nssTools # For installing the root certificate
  ];

#   services.caddy = {
#     enable = true;
#     enableReload = true;
#     configFile = "/home/${me.username}/Documents/Caddyfile";
#   };

#   security.wrappers.caddy = {
#     source = "${pkgs.caddy}/bin/caddy";
#     capabilities = "cap_net_bind_service=+ep";
#     owner = "root";
#     group = "root";
#   };

#   environment.persistence."/persist" = {
#     directories = [
#       "/var/lib/caddy"
#     ];
#     users.${me.username} = {
#       directories = [
#         ".local/share/mkcert"
#         ".config/caddy"
#         ".local/share/caddy"
#       ];
#     };
#   };
}
