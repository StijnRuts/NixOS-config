{ config, pkgs, ... }:
{
  programs.git = {
    enable = true;
    userEmail = "git@stijnruts.be";
    userName = "Stijn Ruts";
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
    };
  };
  programs.git.delta.enable = true;
  programs.lazygit.enable = true;
}
