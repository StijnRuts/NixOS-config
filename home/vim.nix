{
  config,
  pkgs,
  lib,
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

  programs.neovide = {
    enable = true;
    settings = {
      font = {
        normal = "UbuntuMono Nerd Font";
        size = 11;
      };
    };
  };

  home.packages = with pkgs; [
    nvimpager
    vifm
  ];

  home.sessionVariables = {
    PAGER = "nvimpager";
  };

  home.activation.nvimSymlink = lib.hm.dag.entryAfter [ "writeBoundary" ] (''
    ln -sf $HOME/NixOS/home/nvim $HOME/.config
  '');
}
