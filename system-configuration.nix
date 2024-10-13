{ config, pkgs, ... }:
{
  imports = [
    ./system/nix.nix
    ./system/user.nix
    ./system/locale.nix
    ./system/shell.nix
    ./system/desktop.nix
    ./system/networking.nix
    ./system/audio.nix
    ./system/printing.nix
  ];
}
