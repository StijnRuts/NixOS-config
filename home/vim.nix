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

  programs.neovide = {
    enable = true;
    settings = {
      font = {
        normal = "UbuntuMono Nerd Font";
        size = 11;
        width = 1;
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
    if [ -n "\$\{DRY_RUN:-\}" ]; then
      ln -sf ~/NixOS/home/nvim ~/.config
    fi
  '');

  home.persistence."/persist/home/${me.username}" = {
    allowOther = false;
    directories = [
      ".cache/nvim"
      ".local/share/nvim"
      ".local/state/nvim"
    ];
  };
}
