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
      hostname = builtins.getEnv "HOSTNAME";
      myOptions = import ../../hosts/${hostname}/options.nix;
    in
    {
      homeConfigurations.${inputs.config.args.me.username} =
        inputs.home-manager.lib.homeManagerConfiguration
          {
            inherit pkgs;
            extraSpecialArgs = inputs.config.args;
            modules = [ myOptions.home ] ++ inputs.config.homeModules;
          };
    };
}
