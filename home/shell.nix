{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    gnumake
    nixfmt-rfc-style
    nerdfonts
  ];

  programs.wezterm = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    extraConfig = ''
      return {
        hide_tab_bar_if_only_one_tab = true,
        use_fancy_tab_bar = false,
        color_scheme = "Catppuccin Mocha",
        font = wezterm.font 'UbuntuMono Nerd Font',
        font_size = 11,
      }
    '';
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
