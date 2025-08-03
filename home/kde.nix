{ config, pkgs, ... }:
{

  home.file = {
    ".local/share/user-places.xbel".source = ./user-places.xbel;
    ".local/state/konsolestaterc".source = ./konsolestaterc; # hide toolbars
  };

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
              launchers = [
                "applications:org.kde.konsole.desktop"
                "applications:org.kde.dolphin.desktop"
                "applications:neovide.desktop"
                "preferred://browser"
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
    #     "Switch Window Left" = "Meta+H";
    #     "Switch Window Down" = "Meta+J";
    #     "Switch Window Up" = "Meta+K";
    #     "Switch Window Right" = "Meta+L";
    #   };
    # };

    configFile = {
      dolphinrc.General.RememberOpenedTabs = false;
      dolphinrc.PreviewSettings.Plugins = "appimagethumbnail,audiothumbnail,blenderthumbnail,comicbookthumbnail,cursorthumbnail,djvuthumbnail,ebookthumbnail,exrthumbnail,fontthumbnail,imagethumbnail,jpegthumbnail,kraorathumbnail,windowsexethumbnail,windowsimagethumbnail,mobithumbnail,opendocumentthumbnail,gsthumbnail,rawthumbnail,svgthumbnail,ffmpegthumbs"; # No directories
      kwinrc.ElectricBorders.TopLeft = ""; # Disable hot corner
      kwinrc.Effect-overview.BorderActivate = 9; # Disable hot corner
      # TODO set dolphin view to Details
    };

    window-rules =
      let
        maximize = app: {
          description = app;
          match = {
            window-types = [ "normal" ];
            window-class = {
              type = "substring";
              value = app;
            };
          };
          apply = {
            maximizehoriz = true;
            maximizevert = true;
          };
        };
      in
      [
        (maximize "konsole")
        (maximize "dolphin")
        (maximize "neovide")
        (maximize "firefox")
        (maximize "kwrite")
        (maximize "kate")
        (maximize "libreoffice")
        (maximize "gimp")
        (maximize "krita")
        (maximize "inkscape")
      ];

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
  };
}
