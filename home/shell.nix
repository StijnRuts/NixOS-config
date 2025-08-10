{
  config,
  pkgs,
  me,
  ...
}:
{
  home.packages = with pkgs; [
    gnumake
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
    envExtra = ''
      # No beeping
      unsetopt BEEP

      # Run tmux by default
      # Do not run in an existing tmux session, in Dolphin or Kate sessions, or in nix-shell
      if [ -z "$TMUX" ] && [ "$WINDOWID" -ne 0 ] && [ -z "$IN_NIX_SHELL" ]; then
        tmux attach-session -t default || tmux new-session -s default
      fi
    '';
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

  programs.tmux = {
    enable = true;
    mouse = true;
    baseIndex = 1;
    disableConfirmationPrompt = true;
    historyLimit = 5000;
    sensibleOnTop = true;
    plugins = with pkgs.tmuxPlugins; [
      tmux-which-key
      pain-control
      {
        plugin = resurrect;
        extraConfig = "set -g @resurrect-strategy-nvim 'session'";
      }
      {
        plugin = continuum;
        extraConfig = "set -g @continuum-restore 'on'";
      }
    ];
    extraConfig = ''
      # Turn off hostname and clock
      set -g status-right ""

      # Make colors work in nvim
      set -g default-terminal "xterm-256color"
      set-option -ga terminal-overrides ",xterm-256color:Tc"
    '';
  };

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
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
