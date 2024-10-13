{ config, pkgs, ... }:
{
  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  services.displayManager.defaultSession = "plasmax11";

  programs.firefox.enable = true;
}
