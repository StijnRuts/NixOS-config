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

  programs.neovim.extraConfig = ''
    " Use "hybrid" (both absolute and relative) line numbers
    set number relativenumber

    " Use the system clipboard
    set clipboard=unnamed

    " Use space as the leader key
    let mapleader=" "

    " Use <leader><leader> to switch between buffers
    nnoremap <leader><leader> :b#<CR>

    " Press <tab>, get two spaces
    set expandtab shiftwidth=2

    " Show `▸▸` for tabs, `·` for tailing whitespace:
    set list listchars=tab:▸▸,trail:·

    " Enable mouse mode
    set mouse=a
  '';

  catppuccin.nvim.enable = true;

  # systemctl --user status nvim-config.service
  # journalctl --user -u nvim-config.service
  systemd.user.services.nvim-config = {
    Service.ExecStart = "${pkgs.coreutils}/bin/ln -sf /home/${me.username}/NixOS/home/lazyvim /home/${me.username}/.config";
    Install.WantedBy = [ "default.target" ];
    Unit.After = [ "default.target" ];
    Service.Type = "oneshot";
  };

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
