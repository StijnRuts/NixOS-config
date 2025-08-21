{
  config,
  pkgs,
  lib,
  me,
  ...
}:
{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    defaultEditor = true;
    withPython3 = true;
    withNodeJs = true;
    extraPackages = with pkgs; [
      lua51Packages.lua
      lua51Packages.luarocks
      lua51Packages.jsregexp
      fd
      fzf
      gcc
      git
      lazygit
      ripgrep
      tree-sitter
      unzip
      wget
      xclip
    ];
  };

  catppuccin.nvim.enable = true;

  home.file.".config/lazyvim".source = ./nvim;

  home.shellAliases = {
    "lazyvim" = "NVIM_APPNAME=lazyvim nvim";
    "lv" = "lazyvim";
  };

  home.persistence."/persist/home/${me.username}" = {
    allowOther = false;
    directories = [
      ".cache/nvim"
      ".local/share/nvim"
      ".local/state/nvim"
    ];
  };
}
