{ config, pkgs, ... }:
{
  imports = [
    ./system/nix.nix
    ./system/locale.nix
    ./system/network.nix
    ./system/user.nix
    ./system/desktop.nix
  ];
}
