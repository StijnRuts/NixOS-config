{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    gnumake
    neovim
    git
    lazygit
  ];
}
