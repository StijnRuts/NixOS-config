{
  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-25.05";
    };
    catppuccin = {
      url = "github:catppuccin/nix/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    inputs:
    let
      pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
    in
    rec {
      settings = {
        flavor = "mocha";
        Flavor = "Mocha";
        accent = "yellow";
        Accent = "Yellow";
        font = "Ubuntu";
        monofont = "UbuntuMono Nerd Font";
        fontPkg = pkgs.ubuntu_font_family;
        monofontPkg = pkgs.nerd-fonts.ubuntu-mono;
        backgroundColor = "30,30,40";
      };

      modules = {
        nixos = [
          inputs.catppuccin.nixosModules.catppuccin
          {
            environment.systemPackages = [
              settings.fontPkg
            ];

            catppuccin = {
              flavor = settings.flavor;
              accent = settings.accent;
            };

            catppuccin.sddm = {
              enable = true;
              background = ./sddm-background.png;
              loginBackground = true;
              clockEnabled = false;
              userIcon = false;
              font = settings.font;
              fontSize = "16";
            };
          }
        ];

        home = [
          inputs.catppuccin.homeModules.catppuccin
          {
            home.packages = [
              settings.fontPkg
              settings.monofontPkg
              (pkgs.catppuccin-kde.override {
                flavour = [ settings.flavor ];
                accents = [ settings.accent ];
              })
            ];

            catppuccin = {
              flavor = settings.flavor;
              accent = settings.accent;
            };

            gtk = {
              enable = true;
              theme = {
                name = "catppuccin-${settings.flavor}-${settings.accent}-standard";
                package = pkgs.catppuccin-gtk.override {
                  variant = settings.flavor;
                  accents = [ settings.accent ];
                  # size = "compact";
                  # tweaks = [ "black" "rimless" "normal" "float" ];
                };
              };
              iconTheme = {
                name = "Papirus-Dark";
                package = pkgs.catppuccin-papirus-folders.override {
                  flavor = settings.flavor;
                  accent = settings.accent;
                };
              };
              cursorTheme = {
                name = "Simp1e-Catppuccin-Latte";
                package = pkgs.simp1e-cursors;
              };
              font = {
                name = settings.font;
                package = settings.fontPkg;
                size = 11;
              };
            };

            programs.plasma = {
              enable = true;

              workspace = {
                colorScheme = "Catppuccin${settings.Flavor}${settings.Accent}";
                windowDecorations = {
                  library = "org.kde.breeze";
                  theme = "Breeze";
                };
                cursor.theme = "Simp1e-Catppuccin-Latte";
                iconTheme = "Papirus-Dark";
                wallpaperPlainColor = settings.backgroundColor;
              };

              kscreenlocker.appearance.wallpaperPlainColor = settings.backgroundColor;

              fonts = {
                general = {
                  family = settings.font;
                  pointSize = 11;
                };
                fixedWidth = {
                  family = settings.monofont;
                  pointSize = 11;
                };
                small = {
                  family = settings.font;
                  pointSize = 8;
                };
                toolbar = {
                  family = settings.font;
                  pointSize = 11;
                };
                menu = {
                  family = settings.font;
                  pointSize = 11;
                };
                windowTitle = {
                  family = settings.font;
                  pointSize = 11;
                };
              };
            };
          }
        ];
      };
    };
}
