{
  config,
  pkgs,
  lib,
  ...
}:
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

      # shortcuts = {
      #   kwin = {
      #     "Switch Window Left" = [ "Meta+Left" "Meta+H" ];
      #     "Switch Window Down" = [ "Meta+Down" "Meta+J" ];
      #     "Switch Window Up" = [ "Meta+Up" "Meta+K" ];
      #     "Switch Window Right" = [ "Meta+Right" "Meta+L" ];
      #   };
      # };

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
