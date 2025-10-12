{ config, theme, ... }:
{
  programs.niri = {
    settings = {
      layout = {
        focus-ring = {
          enable = false;
          width = 1;
          active.color = config.lib.catppuccin.accent;
          inactive.color = config.lib.catppuccin.surface1;
          urgent.color = config.lib.catppuccin.maroon;
        };
        border = {
          enable = true;
          width = 1;
          active.color = config.lib.catppuccin.accent;
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
        insert-hint.display.color = config.lib.catppuccin.accent;
        background-color = config.lib.catppuccin.mantle;

        gaps = 4;
        struts.top = -2;
        struts.bottom = -4;
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
            bottom-left = 6.0;
            bottom-right = 6.0;
            top-left = 6.0;
            top-right = 6.0;
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
  programs.dankMaterialShell = {
    settings = {
      "currentThemeName" = "cat-${theme.accent}";
      "cornerRadius" = 6;
    };
    session = {
      isLightMode = false;
      wallpaperPath = config.lib.catppuccin.mantle;
    };
  };
}
