{
  config,
  pkgs,
  pkgs-unstable,
  lib,
  me,
  theme,
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

  ########### NVF ###########

  programs.nvf = {
    enable = true;
    settings.vim = {
      viAlias = true;
      vimAlias = true;

      globals = {
        mapleader = " ";
        maplocalleader = " ";
      };

      options = {
        mouse = "a";
        shiftwidth = 2;
        tabstop = 4;
        list = true;
        listchars = "tab:» ,trail:·,nbsp:␣";
      };

      binds.whichKey.enable = true;

      statusline.lualine.enable = true;

      tabline.nvimBufferline = {
        enable = true;
        setupOpts.options.numbers = "none";
      };

      visuals = {
        nvim-scrollbar.enable = true;
        nvim-web-devicons.enable = true;
      };

      ui = {
        borders.enable = true;
        noice.enable = true;
      };

      projects.project-nvim.enable = true;
      session.nvim-session-manager.enable = false;

      utility.motion.flash-nvim.enable = true;

      telescope = {
        enable = true;
        mappings.findFiles = "<leader><leader>";
      };

      utility.yazi-nvim.enable = true;

      git.enable = true;

      terminal.toggleterm = {
        enable = true;
        setupOpts.direction = "float";
        lazygit.enable = true;
      };

      lsp = {
        enable = true;
        # inlayHints.enable = true;
        # lightbulb.enable = true;
        # lspSignature.enable = true;
        # lspconfig.enable = true;
        # lspkind.enable = true;
        # lspsaga.enable = true;
        # nvim-docs-view.enable = true;
        # otter-nvim.enable = true;
        # trouble.enable = true;
      };

      debugger = {
        nvim-dap = {
          enable = true;
          ui.enable = true;
        };
      };

      languages = {
        enableFormat = true;
        enableTreesitter = true;
        enableExtraDiagnostics = true;
        enableDAP = true;

        markdown.enable = true;
        nix.enable = true;
        lua.enable = true;
        html.enable = true;
        css.enable = true;
        ts.enable = true;
        php.enable = true;
        sql.enable = true;
        bash.enable = true;
        haskell.enable = true;

        # Temporary, prettier is not in nixpkgs 25.05
        css.format.package = pkgs-unstable.prettier;
        ts.format.package = pkgs-unstable.prettier;
      };

      autocomplete.blink-cmp.enable = true;

      spellcheck.enable = true;

      theme = {
        enable = true;
        name = "catppuccin";
        style = theme.flavor;
      };
      statusline.lualine.theme = "catppuccin";
    };
  };

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
