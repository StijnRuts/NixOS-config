{ config, lib, ... }:
{
  options.systray.items = lib.mkOption {
    type = lib.types.enum [
      "laptop"
      "desktop"
    ];
    default = "laptop";
    description = "Sets which items should be displayed in the systray";
  };

  config = {
    # nix run github:nix-community/plasma-manager > rc.nix
    programs.plasma = {
      enable = true;

      session.general.askForConfirmationOnLogout = false;
      session.sessionRestore.restoreOpenApplicationsOnLogin = "onLastLogout";

      kwin.virtualDesktops = {
        number = 6;
        rows = 1;
      };

      panels = [
        {
          floating = false;
          height = 36;
          # https://github.com/nix-community/plasma-manager/tree/trunk/modules/widgets
          widgets = [
            {
              name = "org.kde.plasma.kickoff";
              config = {
                icon = "nix-snowflake-white";
              };
            }
            {
              name = "org.kde.plasma.pager";
              config = {
                General = {
                  showWindowIcons = true;
                };
              };
            }
            {
              name = "org.kde.plasma.icontasks";
              config = {
                # ls /run/current-system/sw/share/applications/
                launchers = [
                  "applications:org.kde.konsole.desktop"
                  "applications:org.wezfurlong.wezterm.desktop"
                  "applications:org.kde.dolphin.desktop"
                  "applications:zen-beta.desktop"
                ];
              };
            }
            {
              name = "org.kde.plasma.marginsseparator";
            }
            {
              systemTray.items =
                let
                  shownItems = [
                    "org.kde.plasma.volume"
                    "org.kde.plasma.brightness"
                  ];
                  hiddenItems = [
                    "org.kde.plasma.notifications"
                    "org.kde.plasma.bluetooth"
                    "org.kde.plasma.clipboard"
                  ];
                  laptopItems = [
                    "org.kde.plasma.networkmanagement"
                    "org.kde.plasma.battery"
                  ];
                in
                {
                  "laptop" = {
                    shown = shownItems ++ laptopItems;
                    hidden = hiddenItems;
                  };
                  "desktop" = {
                    shown = shownItems;
                    hidden = hiddenItems ++ laptopItems;
                  };
                }
                .${config.systray.items};
            }
            {
              name = "org.kde.plasma.digitalclock";
              config = {
                Appearance = {
                  showDate = false;
                };
              };
            }
          ];
        }
      ];

      shortcuts = {
        "services/org.kde.krunner.desktop"."_launch" = "Meta+Space";
        "services/org.kde.dolphin.desktop"."_launch" = "Meta+D";
        "services/org.kde.konsole.desktop"."_launch" = "Meta+T";
        "services/org.wezfurlong.wezterm.desktop"."_launch" = "Meta+Shift+T";
        kwin = {
          "Grid View" = "Meta+O";
          "Window Close" = "Meta+Q";

          "Switch Window Left" = [
            "Meta+Left"
            "Meta+H"
          ];
          "Switch Window Down" = [
            "Meta+Down"
            "Meta+J"
          ];
          "Switch Window Up" = [
            "Meta+Up"
            "Meta+K"
          ];
          "Switch Window Right" = [
            "Meta+Right"
            "Meta+L"
          ];

          "Window Quick Tile Left" = [
            "Meta+Ctrl+Left"
            "Meta+Ctrl+H"
          ];
          "Window Quick Tile Bottom" = [
            "Meta+Ctrl+Down"
            "Meta+Ctrl+J"
          ];
          "Window Quick Tile Top" = [
            "Meta+Ctrl+Up"
            "Meta+Ctrl+K"
          ];
          "Window Quick Tile Right" = [
            "Meta+Ctrl+Right"
            "Meta+Ctrl+L"
          ];
          "Window Maximize" = "Meta+F";

          "Switch One Desktop to the Left" = [
            "Meta+Shift+Left"
            "Meta+Shift+H"
          ];
          "Switch One Desktop Down" = [
            "Meta+Shift+Down"
            "Meta+Shift+J"
          ];
          "Switch One Desktop Up" = [
            "Meta+Shift+Up"
            "Meta+Shift+K"
          ];
          "Switch One Desktop to the Right" = [
            "Meta+Shift+Right"
            "Meta+Shift+L"
          ];

          "Window One Desktop to the Left" = [
            "Meta+Ctrl+Shift+Left"
            "Meta+Ctrl+Shift+H"
          ];
          "Window One Desktop Down" = [
            "Meta+Ctrl+Shift+Down"
            "Meta+Ctrl+Shift+J"
          ];
          "Window One Desktop Up" = [
            "Meta+Ctrl+Shift+Up"
            "Meta+Ctrl+Shift+K"
          ];
          "Window One Desktop to the Right" = [
            "Meta+Ctrl+Shift+Right"
            "Meta+Ctrl+Shift+L"
          ];
        };
      };
      configFile = {
        kcminputrc."ButtonRebinds/Mouse" = {
          ExtraButton1 = "Key,Meta+Shift+Left";
          ExtraButton2 = "Key,Meta+Shift+Right";
        };
        # https://docs.kde.org/stable5/en/kwin/kcontrol/windowbehaviour/index.html
        kwinrc.Windows.FocusPolicy = "FocusFollowsMouse";
      };

      # Find device info in /proc/bus/input/devices
      input.touchpads = [
        {
          enable = true;
          name = "Apple Inc. Magic Trackpad 2";
          vendorId = "05ac";
          productId = "0265";
          naturalScroll = false;
        }
      ];

      input.keyboard.numlockOnStartup = "on";

      kwin.nightLight = {
        enable = true;
        mode = "times";
        time = {
          evening = "20:00";
          morning = "07:00";
        };
        temperature = {
          day = 6500;
          night = 3000;
        };
      };

      configFile = {
        kwinrc.ElectricBorders.TopLeft = ""; # Disable hot corner
        kwinrc.Effect-overview.BorderActivate = 9; # Disable hot corner
      };
    };

    persist.home = {
      files = [
        ".config/kwinoutputconfig.json" # Display configuration
      ];
      directories = [
        ".config/session" # For restoreOpenApplicationsOnLogin
      ];
    };
  };
}
