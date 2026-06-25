{
  inputs = {
    nixpkgs-droid.url = "github:NixOS/nixpkgs/nixos-24.05";

    home-manager-droid = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs-droid";
    };

    nix-on-droid = {
      url = "github:nix-community/nix-on-droid/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs-droid";
      inputs.home-manager.follows = "home-manager-droid";
    };
  };

  outputs =
    {
      nixpkgs-droid,
      nix-on-droid,
      ...
    }:
    {
      nixOnDroidConfigurations.default = nix-on-droid.lib.nixOnDroidConfiguration {
        pkgs = import nixpkgs-droid { system = "aarch64-linux"; };
        modules = [ ./nix-on-droid.nix ];
      };
    };
}
