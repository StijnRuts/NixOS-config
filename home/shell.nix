{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    gnumake
  ];

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

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    defaultEditor = true;
  };
}

