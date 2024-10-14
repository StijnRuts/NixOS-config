{ config, pkgs, ... }:
{
  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  services.xserver = {
    windowManager = {
      xmonad = {
        enable = true;
        enableContribAndExtras = true;
        enableConfiguredRecompile = true;
        # extraPackages = haskellPackages : [
        #   haskellPackages.xyz
        # ];
      };
    };
  };

  system.userActivationScripts.xmonadSymlink.text = ''
    ln -sf $HOME/NixOS/system/xmonad $HOME/.config
  '';

  services.displayManager.defaultSession = "plasmax11";

  programs.firefox.enable = true;
}
