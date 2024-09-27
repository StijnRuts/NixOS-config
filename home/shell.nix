{ config, pkgs, ... }:
rec {
  home.packages = with pkgs; [
    gnumake
  ];

  home.shellAliases = {
    "r" = "ranger_cd";

    "gs" = "git status";
    "ga" = "git add";
    "gaa" = "git add --all";
    "gap" = "git add --patch";
    "gd" = "git diff";
    "gdc" = "git diff --cached";
    "gc" = "git commit";
    "gcam" = "git commit --all --message";
    "gco" = "git checkout";
    "gcop" = "git checkout --patch";
    "gb" = "git branch";
    "gp" = "git pull";
    "gpsh" = "git push";
    "gpshf" = "git push --force-with-lease";
    "gpshu" = "git push --set-upstream origin main";
    "gst" = "git stash push";
    "gstp" = "git stash pop";
  };
  programs.bash.shellAliases = home.shellAliases;
  programs.nushell.shellAliases = home.shellAliases;

  home.file = {
    ".config/starship.toml".source = ./starship.toml;
  };

  programs.wezterm = {
    enable = true;
    extraConfig = ''
      return {
        hide_tab_bar_if_only_one_tab = true,
        use_fancy_tab_bar = false,
        color_scheme = "gruvbox",
        font = wezterm.font 'UbuntuMono Nerd Font',
        font_size = 11,
      }
    '';
  };

  programs.bash = {
    enable = true;
    bashrcExtra = ''
      ranger_cd() {
        temp_file=$(mktemp -t "ranger_cd.XXXXXXXXXX")
        ranger --choosedir="$temp_file"
        cd "$(cat -- "$temp_file")"
      }
    '';
  };

  programs.nushell = {
    enable = true;
    extraConfig = ''
      $env.config = {
        show_banner: false,
      }

      def --env ranger_cd [] {
        let temp_file = (mktemp -t "ranger_cd.XXXXXXXXXX")
        ranger --choosedir="$temp_file"
        cd (cat "$temp_file")
      }

      'source /etc/os-release; echo "$PRETTY_NAME, EOL $SUPPORT_END"' | bash -c $in
    '';
  };

  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    enableNushellIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
    enableNushellIntegration = true;
  };

  programs.ranger.enable = true;

  programs.git = {
    enable = true;
    userEmail = "git@stijnruts.be";
    userName = "Stijn Ruts";
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
    };
  };
  programs.git.delta.enable = true;
  programs.lazygit.enable = true;
}
