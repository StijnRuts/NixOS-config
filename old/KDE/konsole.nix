{ theme, ... }:
{
  programs.konsole = {
    enable = true;
    customColorSchemes = {
      "Catppuccin${theme.Flavor}" = ./catppuccin-${theme.flavor}.colorscheme;
    };
    defaultProfile = "Default";
    profiles.default = {
      name = "Default";
      colorScheme = "Catppuccin${theme.Flavor}";
      font = {
        name = theme.monofont;
        size = 11;
      };
    };
  };

  home.file.".local/state/konsolestaterc".source = ./konsolestaterc; # hide toolbars

  # Make Konsole the default terminal app
  programs.plasma.configFile = {
    "kdeglobals"."General"."TerminalService" = "org.kde.konsole.desktop";
  };
}
