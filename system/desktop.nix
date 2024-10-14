{ config, pkgs, ... }:
{
  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  services.displayManager.defaultSession = "plasmax11";

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

  programs.firefox.enable = true;

  services.touchegg.enable = true;
  system.userActivationScripts.touchegg.text = ''
    mkdir -p $HOME/.config/touchegg
    cp $HOME/NixOS/system/touchegg.conf $HOME/.config/touchegg
  '';
}
