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
      number = 4;
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
      "theme".text = ''
        plasma-apply-lookandfeel -a Catppuccin-Mocha-Yellow
        plasma-apply-colorscheme CatppuccinMochaYellow
        plasma-apply-cursortheme Simp1e-Catppuccin-Latte
        ${pkgs.kdePackages.plasma-workspace}/libexec/plasma-changeicons Papirus-Dark
        plasma-apply-wallpaperimage ~/NixOS/home/theme/background.png
        ~/.local/share/plasma-manager/scripts/2_desktop_script_panels.sh
      '';
    };

    workspace = {
      theme = "default"; # plasma-apply-desktoptheme --list-themes
      lookAndFeel = "Catppuccin-Mocha-Yellow"; # plasma-apply-lookandfeel --list
      colorScheme = "CatppuccinMochaYellow"; # plasma-apply-colorscheme --list-schemes
      cursor.theme = "Simp1e-Catppuccin-Latte"; # plasma-apply-cursortheme --list-themes
      iconTheme = "Papirus-Dark";
      wallpaper = ./theme/background.png;
    };

    kscreenlocker.appearance.wallpaper = ./theme/background.png;

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
