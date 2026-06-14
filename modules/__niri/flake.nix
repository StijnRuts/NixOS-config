{
  inputs = {
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dms = {
      url = "github:AvengeMedia/DankMaterialShell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = inputs: {
    nixosModules = [
      inputs.niri.nixosModules.niri
      (
        { pkgs, ... }:
        {
          programs.niri = {
            enable = true;
            package = pkgs.niri;
          };

          environment.systemPackages = with pkgs; [
            xwayland-satellite
            wl-clipboard
            cliphist
          ];

          xdg.menus.enable = true;

          xdg.portal = {
            enable = true;
            wlr.enable = true;
            xdgOpenUsePortal = true;
            extraPortals = [
              pkgs.xdg-desktop-portal
              pkgs.xdg-desktop-portal-wlr
              pkgs.kdePackages.xdg-desktop-portal-kde
            ];
          };
        }
      )
    ];
    homeModules = [
      {
        home.sessionVariables = {
          ELECTRON_OZONE_PLATFORM_HINT = "auto"; # For Electron apps
          XDG_MENU_PREFIX = "plasma-"; # For Dolphin
        };

        programs.niri.settings = {
          spawn-at-startup = [
            {
              command = [
                "dms"
                "run"
              ];
            }
            {
              command = [
                "bash"
                "-c"
                "wl-paste --watch cliphist store &"
              ];
            } # For DMS
          ];
        };
      }
      ./niri.nix
      ./keybinds.nix
      inputs.dms.homeModules.dank-material-shell
      ./dms.nix
      ./dms_keybinds.nix
      ./theme.nix
    ];
  };
}
