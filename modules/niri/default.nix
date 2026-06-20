{
  inputs = {
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs-current";
    };
  };
  outputs = inputs: {
    nixosModules.niri =
      { pkgs, ... }:
      {
        # TODO mkEnableOption
        imports = [
          inputs.niri.nixosModules.niri
        ];
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
    homeModules.niri = {
      # TODO mkEnableOption
      imports = [
        ./settings.nix
        ./keybinds.nix
      ];
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
}
