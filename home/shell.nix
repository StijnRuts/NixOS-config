{
  config,
  pkgs,
  me,
  ...
}:
{
  home.packages = with pkgs; [
    gnumake
    nixfmt-rfc-style
    nixfmt-tree
    killall
  ];

  programs.bash = {
    enable = true;
    enableCompletion = true;
  };

  programs.zsh = {
    enable = true;
    autocd = true;
    autosuggestion.enable = true;
    defaultKeymap = "emacs";
    enableCompletion = true;
    completionInit = "autoload -Uz compinit && compinit && zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'"; # Case insensitive autocomplete
    history.ignoreDups = true;
    syntaxHighlighting.enable = true;
    envExtra = "unsetopt BEEP";
    plugins = [
      {
        name = "zsh-nix-shell";
        file = "nix-shell.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "chisui";
          repo = "zsh-nix-shell";
          rev = "v0.8.0";
          sha256 = "1lzrn0n4fxfcgg65v0qhnj7wnybybqzs4adz7xsrkgmcsr0ii8b7";
        };
      }
    ];
  };

  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };
  home.file.".config/starship.toml".source = ./starship.toml;

  programs.eza = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    icons = "auto";
    git = true;
  };

  programs.ranger.enable = true;
  programs.zsh.shellAliases."r" = "ranger_cd";
  programs.zsh.initContent = ''
    ranger_cd() {
      temp_file=$(mktemp -t "ranger_cd.XXXXXXXXXX")
      ranger --choosedir=$temp_file
      cd "$(cat $temp_file)"
    }
  '';

  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };

  # tmux source-file ~/.config/tmux/tmux.conf
  programs.tmux = {
    enable = true;
    mouse = true;
    baseIndex = 1;
    disableConfirmationPrompt = true;
    historyLimit = 5000;
    sensibleOnTop = true;
    plugins = with pkgs.tmuxPlugins; [
      {
        plugin = catppuccin;
        extraConfig = ''
          set -g @catppuccin_flavor "mocha"
          set -g @catppuccin_window_status_style "rounded"

          set -g status-left ""
          set -g status-right " #{E:@catppuccin_status_session}"

          set -g @catppuccin_window_text " #{window_name}"
          set -g @catppuccin_window_current_text " #{window_name}"
          set -g @catppuccin_window_current_number_color "#{@thm_green}"
        '';
        # set -g @catppuccin_status_fill ""
        # set -g @catppuccin_status_icon "icon"
      }
      /*
      {
        plugin = (
          mkTmuxPlugin {
            pluginName = "tmux-menus";
            version = "v2.2.18";
            rtpFilePath = "menus.tmux";
            #name = "tmux-menus";
            #pluginName = "menus";
            src = pkgs.fetchFromGitHub {
              owner = "jaclu";
              repo = "tmux-menus";
              tag = "v2.2.18";
              hash = "sha256-yJuG24VoM8kykObBC1sV1u3MjsOCHcoI/bftXwokxK0=";
            };
          }
        );
        extraConfig = ''
          set -g @menus_trigger 'Space'
        '';
      }
      (mkTmuxPlugin {
        pluginName = "tmux-which-key";
        version = "main-2024-07-09";
        rtpFilePath = "plugin.sh.tmux";
        #name = "tmux-menus";
        #pluginName = "menus";
        src = pkgs.fetchFromGitHub {
          owner = "alexwforsythe";
          repo = "tmux-which-key";
          rev = "1f419775caf136a60aac8e3a269b51ad10b51eb6";
          hash = "sha256-X7FunHrAexDgAlZfN+JOUJvXFZeyVj9yu6WRnxMEA8E=";
        };
      })
      */
      {
        plugin = pain-control;
        extraConfig = "";
      }
      # tmux-neolazygit or vim-tmux-navigator
      {
        plugin = resurrect;
        extraConfig = ''
          set -g @resurrect-capture-pane-contents 'on'
          set -g @resurrect-strategy-nvim 'session'
        '';
        # TODO: # https://github.com/tpope/vim-obsession
      }
      {
        plugin = continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '10'
        '';
      }
    ];
    extraConfig = ''
      # Renumber when deleting a window
      set-option -g renumber-windows on

      # Make colors work in nvim
      set -g default-terminal "xterm-256color"
      set-option -ga terminal-overrides ",xterm-256color:Tc"
    '';
  };

  programs.direnv = {
    enable = true;
    enableBashIntegration = false;
    enableZshIntegration = false; # Only enabled in WezTerm
  };

  home.persistence."/persist/home/${me.username}" = {
    allowOther = false;
    files = [
      ".bash_history"
      ".zsh_history"
    ];
    directories = [
      ".ssh"
      ".local/share/zoxide"
      ".tmux/resurrect"
      ".local/share/direnv"
    ];
  };
}
