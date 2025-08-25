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
    initContent = ''
      unsetopt BEEP # no beeping
      bindkey "^[[3~" delete-char # fix delete key
      bindkey "^[OH" beginning-of-line # fix home key
      bindkey "^[OF" end-of-line # fix end key
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
      pane_frames = false;
      show_startup_tips = false;
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
      sync_address = "https://atuin.P520.local";
      session_path = config.age.secrets.atuin_session.path;
      key_path = config.age.secrets.atuin_key.path;
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
