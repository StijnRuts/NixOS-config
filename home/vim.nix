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
  };

  home.persistence."/persist/home/${me.username}" = {
    allowOther = false;
    directories = [
      ".cache/nvim"
      ".local/share/nvim"
      ".local/state/nvim"
    ];
  };


  ########### Basic nvim ###########

  programs.neovim.extraLuaConfig = ''
    -- Use "hybrid" (both absolute and relative) line numbers
    vim.wo.number = true
    vim.wo.relativenumber = true

    -- Use the system clipboard
    vim.o.clipboard = "unnamed"

    -- Use space as the leader key
    vim.g.mapleader = " "
    vim.g.maplocalleader = " "

    -- Use <leader><leader> to switch between buffers
    vim.keymap.set('n', '<leader><leader>', ':b#<CR>', { noremap = true })

    -- Press <tab>, get two spaces
    vim.o.expandtab = true
    vim.o.shiftwidth = 2

    -- Show `» ` for tabs, `·` for tailing whitespace
    vim.o.list = true
    vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

    -- Enable mouse mode
    vim.o.mouse = 'a'
  '';

  catppuccin.nvim.enable = true;


  ########### Lazyvim ###########

  programs.neovim = {
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

}
