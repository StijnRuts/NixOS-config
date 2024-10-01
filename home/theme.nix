{ config, pkgs, lib, ... }:
let
  oomoxGruvboxGtk = import ./theme/oomox-gruvbox-gtk.nix { inherit pkgs; };
  oomoxGruvboxIcons = import ./theme/oomox-gruvbox-icons.nix { inherit pkgs; };
in {
  home.packages = with pkgs; [
    ubuntu_font_family
    nerdfonts
  ];

  home.file = {
    ".local/share/color-schemes/oomox-gruvbox.colors".source = ./theme/oomox-gruvbox.colors;
    ".local/share/user-places.xbel".source = ./user-places.xbel;
  };

  home.activation.xmonadSymlink = lib.hm.dag.entryAfter [ "writeBoundary" ] (''
    ln -sf $HOME/NixOS/home/xmonad $HOME/.config
  '');

  programs.wezterm = {
    enable = true;
    colorSchemes = {
      gruvbox = {
        ansi = [
          "#1d2021" "#fb4934" "#b8bb26" "#fabd2f"
          "#83a598" "#d3869b" "#8ec07c" "#d5c4a1"
        ];
        brights = [
          "#797261" "#fb4934" "#b8bb26" "#fabd2f"
          "#83a598" "#d3869b" "#8ec07c" "#fbf1c7"
        ];
        foreground    = "#d5c4a1";
        background    = "#1d2021";
        cursor_bg     = "#d5c4a1";
        cursor_border = "#d5c4a1";
        cursor        = "#d5c4a1";
        selection_bg  = "#d5c4a1";
        selection_fg  = "#1d2021";
      };
    };
  };

  gtk = {
    enable = true;
    theme = {
      name = "oomox-gruvbox-gtk";
      package = oomoxGruvboxGtk;
    };
    iconTheme = {
      name = "oomox-gruvbox-icons";
      package = oomoxGruvboxIcons;
    };
    cursorTheme = {
      name = "Simp1e-Gruvbox-light";
      package = pkgs.simp1e-cursors;
    };
    font = {
      name = "Ubuntu";
      package = pkgs.ubuntu_font_family;
      size = 11;
    };
  };

  programs.plasma = {
    enable = true;

    panels = []; # No panels

    kwin.virtualDesktops = {
      number = 4;
      rows = 1;
    };

    startup.startupScript = {
      "xmonad".text = "xmonad --replace";
    };

    workspace = {
      theme = "default"; # plasma-apply-desktoptheme --list-themes
      lookAndFeel = "org.kde.breezedark.desktop"; # plasma-apply-lookandfeel --list
      colorScheme = "oomox-gruvbox"; # plasma-apply-colorscheme --list-schemes
      cursor.theme = "Simp1e-Gruvbox-Light"; # plasma-apply-cursortheme --list-themes
      iconTheme = "oomox-gruvbox-icons";
      wallpaper = ./theme/bekky-bekks-qMY2-UcG-g8-unsplash.jpg;
    };

   kscreenlocker.appearance.wallpaper = ./theme/bekky-bekks-qMY2-UcG-g8-unsplash.jpg;

    fonts = {
      general = {
        family = "Ubuntu";
        pointSize = 11;
      };
      fixedWidth = {
        family = "UbuntuMono Nerd Font";
        pointSize = 11;
      };
      small = {
        family = "Ubuntu";
        pointSize = 8;
      };
      toolbar = {
        family = "Ubuntu";
        pointSize = 11;
      };
      menu = {
        family = "Ubuntu";
        pointSize = 11;
      };
      windowTitle = {
        family = "Ubuntu";
        pointSize = 11;
      };
    };

    kwin.nightLight = {
      enable = true;
      mode = "location";
      location = {
        latitude = "50.5";
        longitude = "4.5";
      };
      temperature = {
        day = 6500;
        night = 2500;
      };
    };
  };
}
