{
  inputs = {
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs-current";
    };
  };
  outputs = inputs: {
    nixosModules.niri =
      {
        config,
        lib,
        pkgs,
        ...
      }:
      {
        imports = [
          inputs.niri.nixosModules.niri
        ];

        options.custom.niri.enable = lib.mkEnableOption "niri";

        config = lib.mkIf config.custom.niri.enable {
          programs.niri = {
            enable = true;
            package = pkgs.niri;
          };

          environment.systemPackages = with pkgs; [
            #xwayland-satellite
            #wl-clipboard
            #cliphist
          ];

          #xdg.menus.enable = true;

          # TODO
          #xdg.portal = {
          #  enable = true;
          #  wlr.enable = true;
          #  xdgOpenUsePortal = true;
          #  extraPortals = [
          #    pkgs.xdg-desktop-portal
          #    pkgs.xdg-desktop-portal-wlr
          #    pkgs.kdePackages.xdg-desktop-portal-kde
          #  ];
          #};
        };
      };
    homeModules.niri =
      { config, lib, ... }:
      {
        options.custom.niri.enable = lib.mkEnableOption "niri";

        imports = [
          ./settings.nix
          ./keybinds.nix
        ];

        config = lib.mkIf config.custom.niri.enable {
          # TODO
          #home.sessionVariables = {
          #  ELECTRON_OZONE_PLATFORM_HINT = "auto"; # For Electron apps
          #  XDG_MENU_PREFIX = "plasma-"; # For Dolphin
          #};

          programs.niri.settings = {
            spawn-at-startup = [
              #{
              #  command = [
              #    "bash"
              #    "-c"
              #    "wl-paste --watch cliphist store &"
              #  ];
              #}
            ];
          };
        };
      };
  };
}
