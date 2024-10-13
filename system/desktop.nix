{ config, pkgs, ... }:
{
  services.xserver.enable = true;
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.xfce.enable = true;

  environment.xfce.excludePackages = with pkgs; [ xfce.xfce4-terminal ];

  programs.firefox.enable = true;
}
