{ config, pkgs, ... }:
{
  services.printing.enable = true;
  services.printing.drivers = [
    pkgs.gutenprint
    pkgs.gutenprintBin
    pkgs.brlaser
  ];

  environment.systemPackages = with pkgs; [
    system-config-printer
  ];
}
