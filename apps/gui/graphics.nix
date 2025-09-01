{ pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.gimp
    pkgs.krita
    pkgs.inkscape
  ];
}
