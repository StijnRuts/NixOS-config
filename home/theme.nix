{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    ubuntu_font_family
    nerd-fonts.ubuntu-mono
    (catppuccin-kde.override {
      flavour = [ "mocha" ];
      accents = [ "yellow" ];
    })
  ];

  home.file = {
    ".local/share/user-places.xbel".source = ./theme/user-places.xbel;
    ".local/share/konsole/catppuccin-mocha.colorscheme".source = ./theme/catppuccin-mocha.colorscheme;
    ".local/share/konsole/catppuccin.profile".source = ./theme/catppuccin.profile;
    ".config/konsolerc".source = ./theme/konsolerc;
  };

  gtk = {
    enable = true;
    theme = {
      name = "catppuccin-mocha-yellow-standard";
      package = pkgs.catppuccin-gtk.override {
        variant = "mocha";
        accents = [ "yellow" ];
        # size = "compact";
        # tweaks = [ "black" "rimless" "normal" "float" ];
      };
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.catppuccin-papirus-folders.override {
        flavor = "mocha";
        accent = "yellow";
      };
    };
    cursorTheme = {
      name = "Simp1e-Catppuccin-Latte";
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

    kwin.virtualDesktops = {
      number = 6;
      rows = 1;
    };

    panels = [
      {
        floating = false;
        height = 36;
      }
    ];

    startup.startupScript = {
      "xmonad".text = "xmonad --replace";
    };

    workspace = {
      colorScheme = "CatppuccinMochaYellow";
      windowDecorations = {
        library = "org.kde.breeze";
        theme = "Breeze";
      };
      cursor.theme = "Simp1e-Catppuccin-Latte";
      iconTheme = "Papirus-Dark";
      wallpaperPlainColor = "30,30,40";
    };

    kscreenlocker.appearance.wallpaperPlainColor = "30,30,40";

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
