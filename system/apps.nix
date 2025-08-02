{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    libreoffice-qt
    gimp
    krita
    inkscape
  ];
}
