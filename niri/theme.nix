{ theme, ... }:
let
  #rosewater = "\#f5e0dc";
  #flamingo = "\#f2cdcd";
  #pink = "\#f5c2e7";
  #mauve = "\#cba6f7";
  red = "\#f38ba8";
  maroon = "\#eba0ac";
  #peach = "\#fab387";
  yellow = "\#f9e2af";
  #green = "\#a6e3a1";
  #teal = "\#94e2d5";
  #sky = "\#89dceb";
  #sapphire = "\#74c7ec";
  #blue = "\#89b4fa";
  #lavender = "\#b4befe";
  #text = "\#cdd6f4";
  #subtext1 = "\#bac2de";
  #subtext0 = "\#a6adc8";
  #overlay2 = "\#9399b2";
  #overlay1 = "\#7f849c";
  #overlay0 = "\#6c7086";
  #surface2 = "\#585b70";
  #surface1 = "\#45475a";
  #surface0 = "\#313244";
  base = "\#1e1e2e";
  mantle = "\#181825";
  crust = "\#11111b";
  accent = yellow;
in
{
  programs.niri = {
    settings = {

      layout = {
        focus-ring = {
          enable = false;
          width = 1;
          active.color = accent;
          inactive.color = base;
          urgent.color = maroon;
        };
        border = {
          enable = true;
          width = 1;
          active.color = accent;
          inactive.color = base;
          urgent.color = maroon;
        };
        tab-indicator = {
          gap = 0;
          length.total-proportion = 1.0;
          place-within-column = true;
        };
      };

      overview = {
        backdrop-color = crust;
      };

      prefer-no-csd = true;

      window-rules = [
        {
          clip-to-geometry = true;
        }
        {
          # Indicate screencasted windows
          matches = [ { is-window-cast-target = true; } ];
          focus-ring = {
            active.color = red;
            inactive.color = red;
          };
          border = {
            active.color = red;
            inactive.color = red;
          };
        }
      ];
    };
  };
  programs.dankMaterialShell = {
    settings = {
      "currentThemeName" = "cat-${theme.accent}";
    };
    session = {
      isLightMode = false;
      wallpaperPath = mantle;
    };
  };
}
