{ config, theme, ... }:
{
  programs.niri = {
    settings = {
      layout = {
        focus-ring = {
          enable = false;
          width = 1;
          active.color = config.lib.catppuccin.accent;
          inactive.color = config.lib.catppuccin.base;
          urgent.color = config.lib.catppuccin.maroon;
        };
        border = {
          enable = true;
          width = 1;
          active.color = config.lib.catppuccin.accent;
          inactive.color = config.lib.catppuccin.base;
          urgent.color = config.lib.catppuccin.maroon;
        };
        tab-indicator = {
          gap = 0;
          length.total-proportion = 1.0;
          place-within-column = true;
        };
        insert-hint.display.color = config.lib.catppuccin.accent;
        background-color = config.lib.catppuccin.mantle;
      };

      overview = {
        backdrop-color = config.lib.catppuccin.crust;
      };

      prefer-no-csd = true;

      cursor.theme = theme.cursor;

      window-rules = [
        {
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
      "cornerRadius" = 4;
    };
    session = {
      isLightMode = false;
      wallpaperPath = config.lib.catppuccin.mantle;
    };
  };
}
