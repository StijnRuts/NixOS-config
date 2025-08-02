{ config, pkgs, ... }:
{
  imports = [
    ./system/nix.nix
    ./system/user.nix
    ./system/locale.nix
    ./system/desktop.nix
    ./system/networking.nix
    ./system/audio.nix
    ./system/bluetooth.nix
    ./system/printing.nix
    ./system/apps.nix
  ];
}
