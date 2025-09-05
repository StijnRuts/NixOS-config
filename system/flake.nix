{
  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-25.05";
    };
    nixpkgs-unstable = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
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
    args = {
      # pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux; # implicit
      pkgs-unstable = inputs.nixpkgs-unstable.legacyPackages.x86_64-linux;
    };

    nixosModules = [
      (
        { pkgs, ... }:
        {
          environment.systemPackages = with pkgs; [
            gnumake
            nh
            nixfmt-rfc-style
            nixfmt-tree
            statix
            deadnix
          ];
        }
      )
      inputs.impermanence.nixosModules.impermanence
      ./impermanence.nix
      ./persist-nixos.nix
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

    homeModules = [
      inputs.impermanence.homeManagerModules.impermanence
      ./persist-home.nix
      ./home-manager.nix
    ];
  };
}
