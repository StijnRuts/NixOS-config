{
  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-25.05";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    impermanence = {
      url = "github:nix-community/impermanence";
    };
  };
  outputs = inputs: {
    modules = {
      nixos = [
        (
          { pkgs, ... }:
          {
            environment.systemPackages = with pkgs; [
              gnumake
              nh
              nixfmt-rfc-style
              nixfmt-tree
              statix
            ];
          }
        )
        inputs.impermanence.nixosModules.impermanence
        ./impermanence.nix
        ./nix.nix
        inputs.home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            backupFileExtension = "hmbackup";
          };
        }
        ./locale.nix
        ./networking.nix
        ./audio.nix
        ./bluetooth.nix
        ./printing.nix
      ];

      home = [
        inputs.impermanence.homeManagerModules.impermanence
        ./home-manager.nix
      ];
    };
  };
}
