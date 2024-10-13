{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    gnumake
    nixfmt-rfc-style
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
    completionInit = "autoload -Uz compinit && compinit && zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'";
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
      unsetopt BEEP
      source /etc/os-release;
      echo "$PRETTY_NAME, EOL $SUPPORT_END"
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
    icons = true;
    git = true;
  };

  programs.ranger.enable = true;
  programs.zsh.shellAliases."r" = "ranger_cd";
  programs.zsh.initExtra = ''
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
}
