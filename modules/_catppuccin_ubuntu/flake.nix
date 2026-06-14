{
  inputs = {
    catppuccin = {
      url = "github:catppuccin/nix/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = inputs: {
    args.theme =
      let
        pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
      in
      rec {
        flavor = "mocha";
        Flavor = "Mocha";
        accent = "yellow";
        Accent = "Yellow";
        font = "Ubuntu";
        monofont = "UbuntuMono Nerd Font";
        fontPkg = pkgs.ubuntu-classic;
        monofontPkg = pkgs.nerd-fonts.ubuntu-mono;
        cursor = "Simp1e-Catppuccin-Latte";
        cursorPkg = pkgs.simp1e-cursors;
        icons = "Papirus-Dark"; # /etc/profiles/per-user/stijn/share/icons/Papirus-Dark
        iconsPkg = pkgs.catppuccin-papirus-folders.override {
          inherit flavor;
          inherit accent;
        };
        background = {
          rgb = "30,30,40";
          hex = "1E1E28";
        };
      };

    nixosModules = [
      inputs.catppuccin.nixosModules.catppuccin
      ./catppuccin.nix
      (
        { theme, ... }:
        {
          environment.systemPackages = [
            theme.fontPkg
          ];

          catppuccin = {
            inherit (theme) flavor;
            inherit (theme) accent;
          };
        }
      )
    ];

    homeModules = [
      inputs.catppuccin.homeModules.catppuccin
      ./catppuccin.nix
      (
        { pkgs, theme, ... }:
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
            inherit (theme) flavor;
            inherit (theme) accent;
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
              name = theme.icons;
              package = theme.iconsPkg;
            };
            cursorTheme = {
              name = theme.cursor;
              package = theme.cursorPkg;
            };
            font = {
              name = theme.font;
              package = theme.fontPkg;
              size = 11;
            };
          };

          qt = {
            enable = true;
            platformTheme.name = "kde";
          };

          programs.plasma = {
            enable = true;

            workspace = {
              colorScheme = "Catppuccin${theme.Flavor}${theme.Accent}";
              windowDecorations = {
                library = "org.kde.breeze";
                theme = "Breeze";
              };
              cursor.theme = theme.cursor;
              iconTheme = theme.icons;
              wallpaperPlainColor = theme.background.rgb;
            };

            kscreenlocker.appearance.wallpaperPlainColor = theme.background.rgb;

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
        }
      )
    ];
  };
}
