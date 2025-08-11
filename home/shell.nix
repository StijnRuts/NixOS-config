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

  programs.wezterm = {
    enable = true;
    extraConfig = ''
      return {
        font = wezterm.font("UbuntuMono Nerd Font"),
        font_size = 11.0,
        color_scheme = "Catppuccin Mocha",
        hide_tab_bar_if_only_one_tab = true,
        default_prog = {
          "zsh",
          "--login",
          "-c",
          "tmux attach -t default || tmux new -s default;" -- launch tmux
          -- "eval \"$(direnv hook zsh)\";" -- TODO: enable direnv
        },
      }
    '';
  };

  # Set WezTerm as the default terminal app
  programs.plasma.configFile = {
    "kdeglobals"."General"."TerminalService" = "org.wezfurlong.wezterm.desktop";
  };

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
    envExtra = "unsetopt BEEP";
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
      # tmux-which-key
      # tmux-menus # TODO: package
      pain-control
      # tmux-neolazygit
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
      # Turn off hostname and clock
      set -g status-right " 󱄅 "

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
