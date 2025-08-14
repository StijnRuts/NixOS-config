{ config, pkgs, ... }:
{
  programs.wezterm = {
    enable = true;
    extraConfig = ''
      return {
        font = wezterm.font("UbuntuMono Nerd Font"),
        font_size = 11.0,
        color_scheme = "Catppuccin Mocha",
        hide_tab_bar_if_only_one_tab = true,
        use_fancy_tab_bar = false,
      }
    '';
  };

  # Don't make WezTerm the default terminal app
  programs.plasma.configFile = {
    "kdeglobals"."General"."TerminalService" = "org.kde.konsole.desktop";
  };

  programs.zsh = {
    enable = true;
    initContent = ''
      # Setup fancy environment, only on WezTerm
      if [ -n "$WEZTERM_EXECUTABLE" ]; then
        # Enable direnv
        eval "$(direnv hook zsh)"

        # Launch tmux
        # Do not run in an existing tmux session, in nix-shell, or in devenv shell
        if [ -z "$TMUX" ] && [ -z "$IN_NIX_SHELL" ] && [ -z "$DEVENV_DOTFILE" ]; then
          tmux attach-session -t default || tmux new -s default
        fi
      fi
    '';
  };
}
