{ pkgs, ... }:
{
  programs.eww = {
    enable = true;
    configDir = ./eww;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };

  programs.nushell.enable = true;
}
