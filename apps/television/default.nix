{ pkgs-unstable, lib, ... }:
{
  home.packages = [
    pkgs-unstable.television
    pkgs-unstable.eza
    pkgs-unstable.bat
    pkgs-unstable.fd
    pkgs-unstable.ripgrep
    pkgs-unstable.zoxide
  ];

  home.activation.tvSymlink = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    ln -sf ~/NixOS/apps/television/cable ~/.config/television/
  '';

}
