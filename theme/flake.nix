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
    inputs@{ self, ... }:
    {
      pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;

      config = {
        flavor = "mocha";
        Flavor = "Mocha";
        accent = "yellow";
        Accent = "Yellow";
        font = "Ubuntu";
        monofont = "UbuntuMono Nerd Font";
        fontPkg = self.pkgs.ubuntu_font_family;
        monofontPkg = self.pkgs.nerd-fonts.ubuntu-mono;
        backgroundColor = "30,30,40";
      };

      nixosModules = [
        inputs.catppuccin.nixosModules.catppuccin
        {
          environment.systemPackages = [
            self.config.fontPkg
          ];

          catppuccin = {
            flavor = self.config.flavor;
            accent = self.config.accent;
          };

          catppuccin.sddm = {
            enable = true;
            background = ./sddm-background.png;
            loginBackground = true;
            clockEnabled = false;
            userIcon = false;
            font = self.config.font;
            fontSize = "16";
          };
        }
      ];

      homeModules = [
        inputs.catppuccin.homeModules.catppuccin
        {
          home.packages = [
            self.config.fontPkg
            self.config.monofontPkg
            (self.pkgs.catppuccin-kde.override {
              flavour = [ self.config.flavor ];
              accents = [ self.config.accent ];
            })
          ];

          catppuccin = {
            flavor = self.config.flavor;
            accent = self.config.accent;
          };

          gtk = {
            enable = true;
            theme = {
              name = "catppuccin-${self.config.flavor}-${self.config.accent}-standard";
              package = self.pkgs.catppuccin-gtk.override {
                variant = self.config.flavor;
                accents = [ self.config.accent ];
                # size = "compact";
                # tweaks = [ "black" "rimless" "normal" "float" ];
              };
            };
            iconTheme = {
              name = "Papirus-Dark";
              package = self.pkgs.catppuccin-papirus-folders.override {
                flavor = self.config.flavor;
                accent = self.config.accent;
              };
            };
            cursorTheme = {
              name = "Simp1e-Catppuccin-Latte";
              package = self.pkgs.simp1e-cursors;
            };
            font = {
              name = self.config.font;
              package = self.config.fontPkg;
              size = 11;
            };
          };

          programs.plasma = {
            enable = true;

            workspace = {
              colorScheme = "Catppuccin${self.config.Flavor}${self.config.Accent}";
              windowDecorations = {
                library = "org.kde.breeze";
                theme = "Breeze";
              };
              cursor.theme = "Simp1e-Catppuccin-Latte";
              iconTheme = "Papirus-Dark";
              wallpaperPlainColor = self.config.backgroundColor;
            };

            kscreenlocker.appearance.wallpaperPlainColor = self.config.backgroundColor;

            fonts = {
              general = {
                family = self.config.font;
                pointSize = 11;
              };
              fixedWidth = {
                family = self.config.monofont;
                pointSize = 11;
              };
              small = {
                family = self.config.font;
                pointSize = 8;
              };
              toolbar = {
                family = self.config.font;
                pointSize = 11;
              };
              menu = {
                family = self.config.font;
                pointSize = 11;
              };
              windowTitle = {
                family = self.config.font;
                pointSize = 11;
              };
            };
          };
        }
      ];
    };
}
