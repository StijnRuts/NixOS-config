{ pkgs, ... }:
{
  # Read the changelog before changing this value
  home.stateVersion = "24.05";

  home.packages = with pkgs; [
    neovim
    git
    lazygit
    yazi
  ];
}
