{
  pkgs,
  lib,
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
        autoread = true;
        cursorline = true;
        whichwrap = "<,>,h,l";
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
        activeSection = import ./lualine.nix;
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

      utility = {
        motion.flash-nvim.enable = true;
        undotree.enable = true;
      };

      comments.comment-nvim.enable = true;

      telescope = {
        enable = true;
        mappings.findFiles = "<leader><leader>";
      };

      luaConfigRC.telescope = ''
        local actions = require("telescope.actions")

        require("telescope").setup({
          pickers = {
            buffers = {
              mappings = {
                i = {
                  ["<c-d>"] = actions.delete_buffer,
                },
                n = {
                  ["dd"] = actions.delete_buffer,
                },
              },
            },
          },
        })
      '';

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

      treesitter = {
        enable = true;
        highlight.enable = true;
        indent.enable = true;
        fold = true;
        autotagHtml = true;
        addDefaultGrammars = false; # Disabled because of bug
        grammars = pkgs.vimPlugins.nvim-treesitter.allGrammars;
      };

      lsp = {
        enable = true;
        formatOnSave = false;
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
        enableTreesitter = true;
        enableFormat = false;
        enableExtraDiagnostics = true;
        enableDAP = true;

        markdown.enable = true;
        nix.enable = true;
        lua.enable = true;
        html.enable = true;
        css.enable = true;
        # scss.enable = true;
        ts.enable = true;
        # typescript.enable = true;
        json.enable = true;
        yaml.enable = true;
        # xml.enable = true;
        php.enable = true;
        python.enable = true;
        sql.enable = true;
        bash.enable = true;
        nu.enable = true;
        haskell.enable = true;
      };

      autocomplete.blink-cmp.enable = true;

      snippets.luasnip =
        let
          snippetsDir = ./snippets;
          languages = builtins.attrNames (builtins.readDir snippetsDir);
          filesForLanguage = language: builtins.attrNames (builtins.readDir "${snippetsDir}/${language}");
          removeAnySuffix = file: lib.removeSuffix (lib.last (lib.splitString "." file)) file;
          snippetsForLanguage =
            language:
            map (file: {
              trigger = removeAnySuffix file;
              body = builtins.readFile "${snippetsDir}/${language}/${file}";
            }) (filesForLanguage language);
          allSnippets = lib.listToAttrs (
            map (language: {
              name = language;
              value = snippetsForLanguage language;
            }) languages
          );
        in
        {
          enable = true;
          customSnippets.snipmate = allSnippets;
        };

      spellcheck.enable = true;

      keymaps = import ./keymap.nix { inherit lib; };

      lazy.plugins = {
        undotree.keys = [
          {
            mode = [ "n" ];
            key = "<C-z>";
            action = "vim.cmd.UndotreeToggle";
            lua = true;
            desc = "Undotree";
          }
        ];
        toggleterm-nvim.keys = [
          {
            mode = [ "t" ];
            key = "<C-t>";
            action = "<C-\\><C-n>";
          }
        ];
        luasnip.keys = [
          {
            mode = [
              "i"
              "s"
            ];
            key = "<C-n>";
            action = ''function() require("luasnip").jump(1) end'';
            lua = true;
            desc = "Jump to next tabstop";
          }
          {
            mode = [
              "i"
              "s"
            ];
            key = "<C-p>";
            action = ''function() require("luasnip").jump(-1) end'';
            lua = true;
            desc = "Jump to previous tabstop";
          }
        ];
      };

      theme = {
        enable = true;
        name = "catppuccin";
        style = theme.flavor;
      };
      statusline.lualine.theme = "catppuccin";

      notes.neorg = {
        enable = true;
        treesitter.enable = true;
        setupOpts.load."core.defaults".enable = true;
        setupOpts = {
          load = {
            "core.defaults" = { };
            "core.concealer" = { };
            "core.summary" = { };
            "core.dirman" = {
              config = {
                workspaces = {
                  notes = "~/Documents/notes";
                };
                default_workspace = "notes";
              };
            };
          };
        };
      };
    };
  };

  home.shellAliases = {
    "v" = "nvim";
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
