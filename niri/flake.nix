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
            # https://wiki.archlinux.org/title/XDG_Desktop_Portal
            xdg-desktop-portal
            kdePackages.xdg-desktop-portal-kde
            polkit
            kdePackages.polkit-kde-agent-1
            kdePackages.kwallet
            kdePackages.kwallet-pam
            kdePackages.kwalletmanager
            # xdg-desktop-portal
            # xdg-desktop-portal-wlr
            # xdg-desktop-portal-gtk
            # kdePackages.polkit-qt-1
            # xdg-desktop-portal-shana
            # systemctl --user show-environment
            # $XDG_CURRENT_DESKTOP = KDE
            # $WAYLAND_DISPLAY = wayland-0
            # $GTK_THEME Adwaita:dark (unset?!)
            # https://mynixos.com/search?q=portal
            # https://mynixos.com/search?q=polkit
            xwayland-satellite
            wl-clipboard
            cliphist
          ];
        }
      )
    ];
    homeModules = [
      {
        home.sessionVariables = {
          ELECTRON_OZONE_PLATFORM_HINT = "auto"; # For Electron apps
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
