{
  config,
  pkgs,
  theme,
  ...
}:
{
  home.packages = [
    theme.fontPkg
    theme.monofontPkg
    (pkgs.catppuccin-kde.override {
      flavour = [ theme.flavor ];
      accents = [ theme.accent ];
    })
  ];

  catppuccin = {
    flavor = theme.flavor;
    accent = theme.accent;
  };

  gtk = {
    enable = true;
    theme = {
      name = "catppuccin-${theme.flavor}-${theme.accent}-standard";
      package = pkgs.catppuccin-gtk.override {
        variant = theme.flavor;
        accents = [ theme.accent ];
        # size = "compact";
        # tweaks = [ "black" "rimless" "normal" "float" ];
      };
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.catppuccin-papirus-folders.override {
        flavor = theme.flavor;
        accent = theme.accent;
      };
    };
    cursorTheme = {
      name = "Simp1e-Catppuccin-Latte";
      package = pkgs.simp1e-cursors;
    };
    font = {
      name = theme.font;
      package = theme.fontPkg;
      size = 11;
    };
  };

  programs.plasma = {
    enable = true;

    workspace = {
      colorScheme = "Catppuccin${theme.Flavor}${theme.Accent}";
      windowDecorations = {
        library = "org.kde.breeze";
        theme = "Breeze";
      };
      cursor.theme = "Simp1e-Catppuccin-Latte";
      iconTheme = "Papirus-Dark";
      wallpaperPlainColor = theme.backgroundColor;
    };

    kscreenlocker.appearance.wallpaperPlainColor = theme.backgroundColor;

    fonts = {
      general = {
        family = theme.font;
        pointSize = 11;
      };
      fixedWidth = {
        family = theme.monofont;
        pointSize = 11;
      };
      small = {
        family = theme.font;
        pointSize = 8;
      };
      toolbar = {
        family = theme.font;
        pointSize = 11;
      };
      menu = {
        family = theme.font;
        pointSize = 11;
      };
      windowTitle = {
        family = theme.font;
        pointSize = 11;
      };
    };
  };

  programs.konsole = {
    enable = true;
    customColorSchemes = {
      "Catppuccin${theme.Flavor}" = ./catppuccin-${theme.flavor}.colorscheme;
    };
    defaultProfile = "Default";
    profiles.default = {
      name = "Default";
      colorScheme = "Catppuccin${theme.Flavor}";
      font = {
        name = theme.monofont;
        size = 11;
      };
    };
  };

  home.file.".config/process-compose/settings.yaml" = {
    enable = true;
    text = "theme: Catppuccin ${theme.Flavor}";
  };
}
