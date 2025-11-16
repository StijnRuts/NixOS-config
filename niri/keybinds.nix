{ config, ... }:
{
  programs.niri = {
    settings = {
      binds = with config.lib.niri.actions; {
        "Mod+F1".action = show-hotkey-overlay;

        "Mod+T".action.spawn = "konsole";
        "Mod+Shift+T".action.spawn = "wezterm";
        "Mod+D".action.spawn = "dolphin";

        "Mod+O" = {
          action = toggle-overview;
          repeat = false;
        };
        "Mod+Q" = {
          action = close-window;
          repeat = false;
        };
        "Mod+Shift+Q".action = quit;

        "Mod+Left".action = focus-column-left;
        "Mod+Down".action = focus-window-or-workspace-down;
        "Mod+Up".action = focus-window-or-workspace-up;
        "Mod+Right".action = focus-column-right;
        "Mod+H".action = focus-column-left;
        "Mod+J".action = focus-window-or-workspace-down;
        "Mod+K".action = focus-window-or-workspace-up;
        "Mod+L".action = focus-column-right;
        "XF86Back".action = focus-column-left;
        "XF86Forward".action = focus-column-right;
        "Mod+XF86Back".action = focus-column-left;
        "Mod+XF86Forward".action = focus-column-right;

        "Mod+Ctrl+Left".action = move-column-left;
        "Mod+Ctrl+Down".action = move-window-down-or-to-workspace-down;
        "Mod+Ctrl+Up".action = move-window-up-or-to-workspace-up;
        "Mod+Ctrl+Right".action = move-column-right;
        "Mod+Ctrl+H".action = move-column-left;
        "Mod+Ctrl+J".action = move-window-down-or-to-workspace-down;
        "Mod+Ctrl+K".action = move-window-up-or-to-workspace-up;
        "Mod+Ctrl+L".action = move-column-right;
        "Ctrl+XF86Back".action = move-column-left;
        "Ctrl+XF86Forward".action = move-column-right;
        "Mod+Ctrl+XF86Back".action = move-column-left;
        "Mod+Ctrl+XF86Forward".action = move-column-right;

        "Mod+Home".action = focus-column-first;
        "Mod+End".action = focus-column-last;
        "Mod+Page_Down".action = focus-workspace-down;
        "Mod+Page_Up".action = focus-workspace-up;
        "Mod+U".action = focus-workspace-down;
        "Mod+I".action = focus-workspace-up;

        "Mod+Ctrl+Home".action = move-column-to-first;
        "Mod+Ctrl+End".action = move-column-to-last;
        "Mod+Ctrl+Page_Down".action = move-window-to-workspace-down;
        "Mod+Ctrl+Page_Up".action = move-window-to-workspace-up;
        "Mod+Ctrl+U".action = move-window-to-workspace-down;
        "Mod+Ctrl+I".action = move-window-to-workspace-up;

        "Mod+Shift+Page_Down".action = move-workspace-down;
        "Mod+Shift+Page_Up".action = move-workspace-up;
        "Mod+Shift+U".action = move-workspace-down;
        "Mod+Shift+I".action = move-workspace-up;

        "Mod+Shift+Left".action = focus-monitor-left;
        "Mod+Shift+Down".action = focus-monitor-down;
        "Mod+Shift+Up".action = focus-monitor-up;
        "Mod+Shift+Right".action = focus-monitor-right;
        "Mod+Shift+H".action = focus-monitor-left;
        "Mod+Shift+J".action = focus-monitor-down;
        "Mod+Shift+K".action = focus-monitor-up;
        "Mod+Shift+L".action = focus-monitor-right;

        "Mod+Shift+Ctrl+Left".action = move-window-to-monitor-left;
        "Mod+Shift+Ctrl+Down".action = move-window-to-monitor-down;
        "Mod+Shift+Ctrl+Up".action = move-window-to-monitor-up;
        "Mod+Shift+Ctrl+Right".action = move-window-to-monitor-right;
        "Mod+Shift+Ctrl+H".action = move-window-to-monitor-left;
        "Mod+Shift+Ctrl+J".action = move-window-to-monitor-down;
        "Mod+Shift+Ctrl+K".action = move-window-to-monitor-up;
        "Mod+Shift+Ctrl+L".action = move-window-to-monitor-right;

        # Alternative
        # "Mod+Shift+Ctrl+Left".action = move-workspace-to-monitor-left;

        "MouseForward".action = focus-workspace-up;
        "MouseBack".action = focus-workspace-down;

        "Mod+WheelScrollLeft" = {
          action = focus-column-left;
          cooldown-ms = 150;
        };
        "Mod+WheelScrollDown" = {
          action = focus-window-or-workspace-down;
          cooldown-ms = 150;
        };
        "Mod+WheelScrollUp" = {
          action = focus-window-or-workspace-up;
          cooldown-ms = 150;
        };
        "Mod+WheelScrollRight" = {
          action = focus-column-right;
          cooldown-ms = 150;
        };
        "Mod+TouchpadScrollLeft" = {
          action = focus-column-left;
          cooldown-ms = 150;
        };
        "Mod+TouchpadScrollDown" = {
          action = focus-window-or-workspace-down;
          cooldown-ms = 150;
        };
        "Mod+TouchpadScrollUp" = {
          action = focus-window-or-workspace-up;
          cooldown-ms = 150;
        };
        "Mod+TouchpadScrollRight" = {
          action = focus-column-right;
          cooldown-ms = 150;
        };

        "Mod+Ctrl+WheelScrollLeft" = {
          action = move-column-left;
          cooldown-ms = 150;
        };
        "Mod+Ctrl+WheelScrollDown" = {
          action = move-window-down-or-to-workspace-down;
          cooldown-ms = 150;
        };
        "Mod+Ctrl+WheelScrollUp" = {
          action = move-window-up-or-to-workspace-up;
          cooldown-ms = 150;
        };
        "Mod+Ctrl+WheelScrollRight" = {
          action = move-column-right;
          cooldown-ms = 150;
        };
        "Mod+Ctrl+TouchpadScrollLeft" = {
          action = move-column-left;
          cooldown-ms = 150;
        };
        "Mod+Ctrl+TouchpadScrollDown" = {
          action = move-window-down-or-to-workspace-down;
          cooldown-ms = 150;
        };
        "Mod+Ctrl+TouchpadScrollUp" = {
          action = move-window-up-or-to-workspace-up;
          cooldown-ms = 150;
        };
        "Mod+Ctrl+TouchpadScrollRight" = {
          action = move-column-right;
          cooldown-ms = 150;
        };

        "Mod+BracketLeft".action = consume-or-expel-window-left;
        "Mod+BracketRight".action = consume-or-expel-window-right;
        "Mod+Less".action = consume-or-expel-window-left;
        "Mod+Shift+Less".action = consume-or-expel-window-right;

        "Mod+R".action = switch-preset-column-width;
        "Mod+Shift+R".action = switch-preset-window-height;
        "Mod+F".action = maximize-column;
        "Mod+Shift+F".action = fullscreen-window;
        "Mod+C".action = center-column;
        "Mod+Shift+C".action = center-visible-columns;
        "Mod+W".action = toggle-column-tabbed-display;

        "Mod+Minus".action = set-column-width "-10%";
        "Mod+Equal".action = set-column-width "+10%";
        "Mod+Shift+Minus".action = set-window-height "-10%";
        "Mod+Shift+Equal".action = set-window-height "+10%";

        "Mod+A".action = toggle-window-floating;
        "Mod+Shift+A".action = switch-focus-between-floating-and-tiling;

        "Print".action = screenshot;
        "Ctrl+Print".action = screenshot-window;

        "Mod+Shift+Escape" = {
          allow-inhibiting = false;
          action = toggle-keyboard-shortcuts-inhibit;
        };
      };
    };
  };
}
