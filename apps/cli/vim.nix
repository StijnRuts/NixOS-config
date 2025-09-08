{
  pkgs,
  pkgs-unstable,
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
        softtabstop = 2;
        expandtab = true;
        list = true;
        listchars = "tab:» ,trail:·,nbsp:␣";
      };

      binds.whichKey.enable = true;

      statusline.lualine = {
        enable = true;
        activeSection = import ./vim-lualine.nix;
      };

      tabline.nvimBufferline = {
        enable = true;
        setupOpts.options.numbers = "none";
      };

      visuals = {
        nvim-scrollbar.enable = true;
        nvim-web-devicons.enable = true;
        indent-blankline = {
          enable = true;
          setupOpts.scope.enabled = true;
        };
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
        mappings.buffers = "<leader><leader>";
      };

      utility.yazi-nvim = {
        enable = true;
        setupOpts.open_for_directories = true;
        mappings = {
          yaziToggle = "<leader>yy";
          openYazi = "<leader>Y";
          openYaziDir = "<leader>yw";
        };
      };

      git = {
        gitsigns.enable = true;
        vim-fugitive.enable = true;
      };

      terminal.toggleterm = {
        enable = true;
        setupOpts.direction = "float";
        lazygit = {
          enable = true;
          mappings.open = "<leader>gg";
        };
      };
      keymaps = [
        {
          mode = [ "t" ];
          key = "<C-t>";
          action = "<C-\\><C-n>";
        }
      ];

      treesitter = {
        enable = true;
        addDefaultGrammars = true;
        fold = true;
      };

      lsp = {
        enable = true;
        nvim-docs-view.enable = true;
        otter-nvim.enable = true;
        trouble.enable = true;
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

  home.shellAliases = {
    "nvim-config" = "nvf-print-config | stylua - | bat --language=lua";
  };

  home.packages = [ pkgs.stylua ];

  persist.home = {
    directories = [
      ".cache/nvim"
      ".local/share/nvim"
      ".local/state/nvim"
    ];
  };
}
