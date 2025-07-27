{ config, pkgs, ... }:
{
  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  programs.firefox.enable = true;

  services.touchegg.enable = true;
  system.userActivationScripts.touchegg.text = ''
    mkdir -p $HOME/.config/touchegg
    cp $HOME/NixOS/system/touchegg.conf $HOME/.config/touchegg
  '';
}
