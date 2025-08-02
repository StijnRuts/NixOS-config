{ config, pkgs, ... }:
{

  home.file = {
    ".local/share/user-places.xbel".source = ./user-places.xbel;
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
            name = "org.kde.plasma.systemtray";
            config = {
              items = {
                # TODO check
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
      # https://github.com/dominikstraessle/plasma-manager/blob/b5e04d3d6cd81efc121ada365a506408fa31bac6/modules/dolphin.nix
      dolphinrc.General.RememberOpenedTabs = false;
      # TODO default view mode Details
      dolphinrc.PreviewSettings.Plugins = "appimagethumbnail,audiothumbnail,blenderthumbnail,comicbookthumbnail,cursorthumbnail,djvuthumbnail,ebookthumbnail,exrthumbnail,fontthumbnail,imagethumbnail,jpegthumbnail,kraorathumbnail,windowsexethumbnail,windowsimagethumbnail,mobithumbnail,opendocumentthumbnail,gsthumbnail,rawthumbnail,svgthumbnail,ffmpegthumbs"; # No directories
    };

    # TODO Konsole no toolbars

    # TODO screen edges disabled

    window-rules = [
      {
        description = "Konsole";
        match = {
          window-class = {
            value = "konsole";
            type = "substring";
          };
          window-types = [ "normal" ];
        };
        apply = {
          maximizehoriz = true;
          maximizevert = true;
        };
      }
      {
        description = "Dolphin";
        match = {
          window-class = {
            value = "dolphin";
            type = "substring";
          };
          window-types = [ "normal" ];
        };
        apply = {
          maximizehoriz = true;
          maximizevert = true;
        };
      }
      {
        description = "Neovide";
        match = {
          window-class = {
            value = "neovide";
            type = "substring";
          };
          window-types = [ "normal" ];
        };
        apply = {
          maximizehoriz = true;
          maximizevert = true;
        };
      }
      {
        description = "Firefox";
        match = {
          window-class = {
            value = "firefox";
            type = "substring";
          };
          window-types = [ "normal" ];
        };
        apply = {
          maximizehoriz = true;
          maximizevert = true;
        };
      }
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
