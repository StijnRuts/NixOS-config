{ config, ... }:
{
  programs.niri = {
    settings =
      let
        dms-ipc = config.lib.niri.actions.spawn "dms" "ipc";
      in
      {
        binds = {
          "Mod+Space" = {
            action = dms-ipc "spotlight" "toggle";
            hotkey-overlay.title = "Toggle Application Launcher";
          };
          "Mod+N" = {
            action = dms-ipc "notifications" "toggle";
            hotkey-overlay.title = "Toggle Notification Center";
          };
          "Mod+P" = {
            action = dms-ipc "notepad" "toggle";
            hotkey-overlay.title = "Toggle Notepad";
          };
          "Mod+V" = {
            action = dms-ipc "clipboard" "toggle";
            hotkey-overlay.title = "Toggle Clipboard Manager";
          };
          "XF86AudioRaiseVolume" = {
            allow-when-locked = true;
            action = dms-ipc "audio" "increment" "3";
          };
          "XF86AudioLowerVolume" = {
            allow-when-locked = true;
            action = dms-ipc "audio" "decrement" "3";
          };
          "XF86AudioMute" = {
            allow-when-locked = true;
            action = dms-ipc "audio" "mute";
          };
          "XF86AudioMicMute" = {
            allow-when-locked = true;
            action = dms-ipc "audio" "micmute";
          };
          "XF86MonBrightnessUp" = {
            allow-when-locked = true;
            action = dms-ipc "brightness" "increment" "5";
          };
          "XF86MonBrightnessDown" = {
            allow-when-locked = true;
            action = dms-ipc "brightness" "decrement" "5";
          };
        };

        switch-events = {
          "lid-close".action = dms-ipc "call" "lock" "lock";
        };
      };
  };
}
