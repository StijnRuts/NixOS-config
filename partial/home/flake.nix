{
  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-25.05";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    config = {
      url = "path:../..";
    };
  };
  outputs =
    inputs:
    let
      pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
      userConfig = (import ../../user/flake.nix).outputs { };
      hostname = builtins.getEnv "HOSTNAME";
      extraArgs = import ../../hosts/${hostname}/args.nix;
    in
    {
      homeConfigurations.${userConfig.args.me.username} =
        inputs.home-manager.lib.homeManagerConfiguration
          {
            inherit pkgs;
            extraSpecialArgs = inputs.config.args // extraArgs;
            modules = inputs.config.homeModules;
          };
    };
}
