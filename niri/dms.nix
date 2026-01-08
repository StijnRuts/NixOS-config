{ pkgs-unstable, ... }:
{
  programs.dank-material-shell = {
    enable = true;

    systemd = {
      enable = true;
      restartIfChanged = true;
    };

#     niri = {
#       enableKeybinds = true;
#       enableSpawn = true;
#     };

    dgop.package = pkgs-unstable.dgop;

    settings = {
      controlCenterWidgets = [
        {
          id = "volumeSlider";
          enabled = true;
          width = 50;
        }
        {
          id = "brightnessSlider";
          enabled = true;
          width = 50;
        }
        {
          id = "wifi";
          enabled = true;
          width = 50;
        }
        {
          id = "bluetooth";
          enabled = true;
          width = 50;
        }
        {
          id = "audioOutput";
          enabled = true;
          width = 50;
        }
        {
          id = "audioInput";
          enabled = true;
          width = 50;
        }
        {
          id = "nightMode";
          enabled = true;
          width = 50;
        }
        {
          id = "darkMode";
          enabled = true;
          width = 50;
        }
        {
          id = "doNotDisturb";
          enabled = true;
          width = 50;
        }
        {
          id = "idleInhibitor";
          enabled = true;
          width = 50;
        }
      ];
      dankBarLeftWidgets = [
        "launcherButton"
      ];
      dankBarCenterWidgets = [
        "clock"
      ];
      dankBarRightWidgets = [
        "systemTray"
        "clipboard"
        "notificationButton"
        "battery"
        "controlCenterButton"
      ];
      clockDateFormat = "ddd d MMM";
      weatherLocation = "Hasselt, Limburg";
      weatherCoordinates = "50.9303735,5.3378043";
      fontFamily = "Ubuntu";
      monoFontFamily = "UbuntuMono Nerd Font";
      dankBarAutoHide = false;
      dankBarVisible = true;
      dankBarSpacing = 0;
      dankBarBottomGap = 0;
      dankBarInnerPadding = 0;
      dankBarSquareCorners = true;
      dankBarPosition = 0;
      showDock = true;
      dockAutoHide = true;
      dockPosition = 1;
    };

    session = {
      nightModeAutoEnabled = true;
      nightModeTemperature = 2500;
      nightModeAutoMode = "time";
      nightModeStartHour = 20;
      nightModeStartMinute = 0;
      nightModeEndHour = 7;
      nightModeEndMinute = 0;
      acMonitorTimeout = 300;
      acLockTimeout = 600;
      acSuspendTimeout = 600;
      batteryMonitorTimeout = 300;
      batteryLockTimeout = 600;
      batterySuspendTimeout = 600;
      pinnedApps = [
        "zen-beta"
        "nyxt"
        "Logseq"
        "beekeeper-studio"
        "org.kde.kate"
        "org.kde.kwrite"
        "org.kde.dolphin"
        "org.wezfurlong.wezterm"
        "org.kde.konsole"
      ];
    };
  };
}
