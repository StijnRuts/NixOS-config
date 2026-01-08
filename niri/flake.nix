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
