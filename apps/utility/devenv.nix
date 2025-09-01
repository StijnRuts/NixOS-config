{ pkgs-unstable, me, ... }:
{
  environment.systemPackages = [
    pkgs-unstable.devenv
  ];

  nix.settings.trusted-users = [
    "${me.username}"
  ];
}
