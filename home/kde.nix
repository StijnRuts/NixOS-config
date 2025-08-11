{
  config,
  pkgs,
  lib,
  me,
  ...
}:
{
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
        widgets = [
          {
            name = "org.kde.plasma.kickoff";
            config = {
              icon = "nix-snowflake";
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
                "applications:neovide.desktop"
                "applications:firefox.desktop"
              ];
            };
          }
          {
            name = "org.kde.plasma.marginsseparator";
          }
          {
            systemTray.items = {
              shown = [
                "org.kde.plasma.volume"
                "org.kde.plasma.brightness"
                "org.kde.plasma.networkmanagement"
                "org.kde.plasma.battery"
              ];
              hidden = [
                "org.kde.plasma.notifications"
                "org.kde.plasma.bluetooth"
                "org.kde.plasma.clipboard"
              ];
            };
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

    window-rules =
      let
        maximizeByClass = app: {
          description = app;
          match = {
            window-types = [ "normal" ];
            window-class = {
              type = "substring";
              value = app;
            };
          };
          apply = maximize;
        };
        maximizeByTitle = app: title: {
          description = app;
          match = {
            window-types = [ "normal" ];
            title = {
              type = "exact";
              value = title;
            };
          };
          apply = maximize;
        };
        maximize = {
          maximizehoriz = {
            apply = "initially";
            value = true;
          };
          maximizevert = {
            apply = "initially";
            value = true;
          };
        };
      in
      [
        # Find class name via:
        # System Settings > Window Management > Window rules > Edit > Detect Window Properties
        (maximizeByClass "konsole")
        (maximizeByTitle "dolphin" "Home — Dolphin")
        (maximizeByClass "neovide")
        (maximizeByClass "firefox")
        (maximizeByClass "kwrite")
        (maximizeByTitle "kate" "Welcome — Kate") # TODO: Fix
        (maximizeByClass "libreoffice")
        (maximizeByClass "gimp")
        (maximizeByClass "krita")
        (maximizeByClass "inkscape")
        (maximizeByClass "beekeeper-studio")
      ];

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
      dolphinrc.General.RememberOpenedTabs = false; # Always open home directory
      dolphinrc.PreviewSettings.Plugins = "appimagethumbnail,audiothumbnail,blenderthumbnail,comicbookthumbnail,cursorthumbnail,djvuthumbnail,ebookthumbnail,exrthumbnail,fontthumbnail,imagethumbnail,jpegthumbnail,kraorathumbnail,windowsexethumbnail,windowsimagethumbnail,mobithumbnail,opendocumentthumbnail,gsthumbnail,rawthumbnail,svgthumbnail,ffmpegthumbs"; # No preview for directories
      kwinrc.ElectricBorders.TopLeft = ""; # Disable hot corner
      kwinrc.Effect-overview.BorderActivate = 9; # Disable hot corner
      konsolerc."Notification Messages".CloseAllTabs = true; # Don't ask when closing window (because of tmux)
    };
  };

  home.file = {
    ".local/share/user-places.xbel".source = ./user-places.xbel;
    ".local/state/konsolestaterc".source = ./konsolestaterc; # hide toolbars
  };

  # Set Dolphin view mode to Details
  home.activation.setDolphinXattrs = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    mkdir -p ~/.local/share/dolphin/view_properties/global
    ${pkgs.attr}/bin/setfattr -n user.kde.fm.viewproperties#1 -v $'[Dolphin]\nViewMode=1' ~/.local/share/dolphin/view_properties/global
  '';

  home.persistence."/persist/home/${me.username}" = {
    allowOther = false;
    directories = [
      ".config/session" # For restoreOpenApplicationsOnLogin
    ];
  };
}
