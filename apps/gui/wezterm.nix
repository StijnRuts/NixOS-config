{ theme, ... }:
{
  programs.wezterm = {
    enable = true;
    extraConfig = ''
      return {
        font = wezterm.font("${theme.monofont}"),
        font_size = 11.0,
        color_scheme = "Catppuccin ${theme.Flavor}",
        hide_tab_bar_if_only_one_tab = true,
        use_fancy_tab_bar = false,
        window_close_confirmation = 'NeverPrompt',
      }
    '';
  };

  programs.zsh = {
    enable = true;
    initContent = ''
      # Setup fancy environment, only on WezTerm
      if [ -n "$WEZTERM_EXECUTABLE" ]; then
        # Enable direnv
        if command -v direnv >/dev/null 2>&1; then
          eval "$(direnv hook zsh)"
        fi
        # If not in nix-shell or devenv
        if [ -z "$IN_NIX_SHELL" ] && [ -z "$DEVENV_DOTFILE" ]; then
          # Launch zellij
          if command -v zellij >/dev/null 2>&1; then
            # If not already in Zellij
            if [[ -z "$ZELLIJ" ]]; then
              zellij attach -c default
            fi
          fi
        fi
      fi
    '';
  };
}
