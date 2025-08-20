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

  # systemctl --user status nvim-config.service
  # journalctl --user -u nvim-config.service
  systemd.user.services.nvim-config = {
    Service.ExecStart = "${pkgs.coreutils}/bin/ln -sf /home/${me.username}/NixOS/home/nvim /home/${me.username}/.config/lazyvim";
    Install.WantedBy = [ "default.target" ];
    Unit.After = [ "default.target" ];
    Service.Type = "oneshot";
  };

  home.shellAliases = {
    "lazyvim" = "NVIM_APPNAME=lazyvim nvim";
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
