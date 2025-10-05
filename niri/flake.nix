{
  inputs = {
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dankMaterialShell = {
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
      ./niri.nix
      ./keybinds.nix
      "${inputs.hm-unstable}/modules/programs/quickshell.nix" # Temporary
      inputs.dankMaterialShell.homeModules.dankMaterialShell.default
      ./dms.nix
      ./dms_keybinds.nix
      ./theme.nix
    ];
  };
}
