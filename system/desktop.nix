{ config, pkgs, ... }:
{
  imports = [
    ./desktop/shell.nix
    ./desktop/audio.nix
    ./desktop/printing.nix
  ];

  services.xserver.enable = true;
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.xfce.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  programs.firefox.enable = true;
}
