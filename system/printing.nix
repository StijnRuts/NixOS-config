{ config, pkgs, ... }:
{
  services.printing.enable = true;
  services.printing.drivers = [
    pkgs.gutenprint
    pkgs.gutenprintBin
    pkgs.brlaser
  ];
}
