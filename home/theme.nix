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
  };

  programs.konsole = {
    enable = true;
    customColorSchemes = {
      CatppuccinMocha = ./catppuccin-mocha.colorscheme;
    };
    defaultProfile = "Default";
    profiles.default = {
      name = "Default";
      colorScheme = "CatppuccinMocha";
      font = {
        name = "UbuntuMono Nerd Font";
        size = 11;
      };
    };
  };
}
