{
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

    layout = {
      gaps = 0;
      struts.left = 12;
      struts.right = 12;

      default-column-width = { };

      preset-column-widths = [
        { proportion = 1. / 3.; }
        { proportion = 1. / 2.; }
        { proportion = 2. / 3.; }
      ];
      preset-window-heights = [
        { proportion = 1. / 3.; }
        { proportion = 1. / 2.; }
        { proportion = 2. / 3.; }
      ];

      tab-indicator = {
        hide-when-single-tab = true;
      };
    };

    hotkey-overlay.skip-at-startup = true;
    gestures.hot-corners.enable = false;

    window-rules = [
      {
        matches = [ { app-id = "wezterm"; } ];
        default-column-width.proportion = 1.0;
      }
    ];

    layer-rules = [
      {
        matches = [ { namespace = "^notifications$"; } ];
        block-out-from = "screencast";
      }
    ];
  };
}
