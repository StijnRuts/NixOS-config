{ pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.libreoffice-qt
  ];
}
