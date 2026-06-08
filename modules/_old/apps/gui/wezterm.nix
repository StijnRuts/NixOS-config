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
}
