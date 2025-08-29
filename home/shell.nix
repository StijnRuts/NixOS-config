{
  pkgs,
  lib,
  me,
  theme,
  ...
}:
{
  home.packages = with pkgs; [
    gnumake
    nh
    nixfmt-rfc-style
    nixfmt-tree
    statix
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
    initContent = ''
      unsetopt BEEP # no beeping
      bindkey "^[[3~" delete-char # fix delete key
      bindkey "^[OH" beginning-of-line # fix home key
      bindkey "^[OF" end-of-line # fix end key
      bindkey "^[OA" up-line-or-history # fix up key
      bindkey "^[OB" down-line-or-history # fix down key
      bindkey "^[OC" forward-char # fix right key
      bindkey "^[OD" backward-char # fix left key
    '';
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

  programs.bat = {
    enable = true;
    extraPackages = [ pkgs.bat-extras.core ];
  };
  catppuccin.bat.enable = true;
  home.shellAliases = {
    "cat" = "bat --paging=never";
    "less" = "bat --paging=always";
    "man" = "batman";
  };
  programs.zsh.shellGlobalAliases = {
    "--help" = "--help 2>&1 | bat --language=help --style=plain";
  };

  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };

  programs.yazi = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    shellWrapperName = "y";
  };
  catppuccin.yazi.enable = true;
  catppuccin.yazi.accent = "blue";

  programs.zellij = {
    enable = true;
    enableBashIntegration = false;
    enableZshIntegration = false; # Only enabled in WezTerm
    attachExistingSession = false; # Set in WezTerm config
    settings = {
      default_mode = "locked";
      pane_frames = false;
      show_startup_tips = false;
      simplified_ui = true;
      session_serialization = true;
      pane_viewport_serialization = true;
      scrollback_lines_to_serialize = 500;
    };
  };
  catppuccin.zellij.enable = true;

  programs.atuin = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    daemon.enable = true;
    settings = {
      show_help = false;
      show_tabs = false;
      show_preview = false;
      enter_accept = true;
      style = "auto";
      inline_height = 11;
      filter_mode = "global";
      filter_mode_shell_up_key_binding = "workspace";
      workspaces = true;
    };
  };
  catppuccin.atuin.enable = true;

  programs.direnv = {
    enable = true;
    enableBashIntegration = false;
    enableZshIntegration = false; # Only enabled in WezTerm
    nix-direnv.enable = true;
  };

  # process-compose, used by devenv
  home.file = {
    ".config/process-compose/shortcuts.yaml".text = lib.generators.toYAML { } {
      shortcuts.quit.shortcut = "q";
    };
    ".config/process-compose/settings.yaml".text = lib.generators.toYAML { } {
      disable_exit_confirmation = true;
      theme = "Catppuccin ${theme.Flavor}";
    };
  };

  # TODO: Wait for PR: https://github.com/nix-community/home-manager/pull/7736
  /*
    programs.process-compose = {
      enable = true;
      settings = {
        disable_exit_confirmation = true;
        theme = "Catppuccin ${theme.Flavor}";
      };
      shortcuts = {
        quit.shortcut = "q";
      };
    };
  */

  home.persistence."/persist/home/${me.username}" = {
    allowOther = false;
    files = [
      ".bash_history"
      ".zsh_history"
    ];
    directories = [
      ".ssh"
      ".local/share/zoxide"
      ".cache/zellij"
      ".local/share/atuin"
      ".local/share/direnv"
    ];
  };
}
