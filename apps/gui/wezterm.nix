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
        if command -v direnv; then
          eval "$(direnv hook zsh)"
        fi
        # Launch zellij
        if command -v zellij; then
          if [[ -z "$ZELLIJ" ]]; then
            zellij attach -c default
          fi
        fi
      fi
    '';
  };
}
