{
  config,
  lib,
  pkgs,
  ...
}:
{
  services.xserver = {
    enable = true;
    displayManager.lightdm.enable = true;
    desktopManager = {
      xfce = {
        enable = true;
        enableXfwm = false;
        # noDesktop = true;
      };
    };
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

  services.displayManager.defaultSession = "xfce+xmonad";

  system.userActivationScripts.xmonadSymlink.text = ''
    ln -sf $HOME/NixOS/system/xmonad $HOME/.config
  '';

  services.xserver.desktopManager.xterm.enable = false;
  environment.xfce.excludePackages = with pkgs; [
    xfce.xfce4-terminal # replaced with wezterm
    xfce.parole # replaced with vlc
  ];

  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-archive-plugin
      thunar-volman
    ];
  };

  environment.systemPackages = with pkgs; [
    wezterm
    dmenu
    xarchiver
    vlc
    touchegg
  ];

  programs.firefox.enable = true;

  services.touchegg.enable = true;
  system.userActivationScripts.touchegg.text = ''
    mkdir -p $HOME/.config/touchegg
    cp $HOME/NixOS/system/touchegg.conf $HOME/.config/touchegg
  '';
}
