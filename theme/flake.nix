{
  inputs = {
    catppuccin = {
      url = "github:catppuccin/nix/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = inputs: {
    args.theme =
      let
        pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
      in
      {
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

    nixosModules = [
      inputs.catppuccin.nixosModules.catppuccin
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
              name = "Papirus-Dark";
              package = pkgs.catppuccin-papirus-folders.override {
                inherit (theme) flavor;
                inherit (theme) accent;
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

          qt = {
            enable = true;
            platformTheme.name = "kde6";
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
        }
      )
    ];
  };
}
