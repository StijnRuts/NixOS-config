{ config, theme, ... }:
{
  programs.niri = {
    settings = {
      layout = {
        focus-ring = {
          enable = false;
          width = 1;
          active.color = config.lib.catppuccin.overlay1;
          inactive.color = config.lib.catppuccin.surface1;
          urgent.color = config.lib.catppuccin.maroon;
        };
        border = {
          enable = true;
          width = 1;
          active.color = config.lib.catppuccin.overlay1;
          inactive.color = config.lib.catppuccin.surface1;
          urgent.color = config.lib.catppuccin.maroon;
        };
        tab-indicator = {
          gap = 1;
          gaps-between-tabs = 3;
          corner-radius = 2;
          length.total-proportion = 0.95;
          place-within-column = true;
        };
        insert-hint.display.color = config.lib.catppuccin.overlay0;
        background-color = config.lib.catppuccin.mantle;

        gaps = 0;
        struts.top = 0;
        struts.bottom = 0;
        struts.left = 10;
        struts.right = 10;
      };

      overview = {
        backdrop-color = config.lib.catppuccin.crust;
      };

      prefer-no-csd = true;

      cursor.theme = theme.cursor;

      window-rules = [
        {
          geometry-corner-radius = {
            bottom-left = 0.0;
            bottom-right = 0.0;
            top-left = 0.0;
            top-right = 0.0;
          };
          clip-to-geometry = true;
        }
        {
          # Indicate screencasted windows
          matches = [ { is-window-cast-target = true; } ];
          focus-ring = {
            active.color = config.lib.catppuccin.red;
            inactive.color = config.lib.catppuccin.red;
          };
          border = {
            active.color = config.lib.catppuccin.red;
            inactive.color = config.lib.catppuccin.red;
          };
        }
      ];
    };
  };
  programs.dank-material-shell = {
    settings = {
      "currentThemeName" = "cat-${theme.accent}";
      "cornerRadius" = 0;
    };
    session = {
      isLightMode = false;
      wallpaperPath = config.lib.catppuccin.mantle;
    };
  };
}
