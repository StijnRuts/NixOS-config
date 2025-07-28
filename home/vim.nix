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

  home.packages = with pkgs; [
    neovim-qt
    nvimpager
    vifm
  ];

  home.activation.nvimSymlink = lib.hm.dag.entryAfter [ "writeBoundary" ] (''
    ln -sf $HOME/NixOS/home/nvim $HOME/.config
  '');
}
