{ config, pkgs, home-manager, ... }:
{
  programs.home-manager.enable = true;
  home.username = "stijn";
  home.homeDirectory = "/home/stijn";
  home.stateVersion = "24.05";

  imports = [
    ./home/shell.nix
  ];
}
