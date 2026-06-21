{ config, lib, ... }:
{
  config = lib.mkIf config.custom.niri.enable {
    programs.niri.settings = {
      # https://github.com/sodiboo/niri-flake/blob/main/docs.md#programsnirisettings

      input = {
        keyboard = {
          xkb.layout = "be";
          numlock = true;
        };
        touchpad = {
          natural-scroll = false;
          accel-speed = 0.4;
          tap = true;
          scroll-method = "two-finger";
        };
        focus-follows-mouse = {
          enable = true;
          max-scroll-amount = "100%";
        };
        warp-mouse-to-focus.enable = true;
      };

      clipboard.disable-primary = true;

      layout = {
        default-column-width = { };

        preset-column-widths = [
          { proportion = 0.333; }
          { proportion = 0.5; }
          { proportion = 0.666; }
          { proportion = 0.85; }
        ];
        preset-window-heights = [
          { proportion = 0.333; }
          { proportion = 0.5; }
          { proportion = 0.666; }
        ];

        empty-workspace-above-first = true;

        tab-indicator = {
          hide-when-single-tab = true;
        };
      };

      hotkey-overlay.skip-at-startup = true;
      gestures.hot-corners.enable = false;

      # niri msg pick-window
      window-rules = [
        {
          matches = [ { app-id = "someapp"; } ];
          open-maximized = true;
        }
      ];

      # niri msg layers
      layer-rules = [
        {
          matches = [ { namespace = "notification"; } ];
          block-out-from = "screencast";
        }
      ];
    };
  };
}
