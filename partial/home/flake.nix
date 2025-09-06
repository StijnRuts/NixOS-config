{
  inputs = {
    config = {
      url = "path:../..";
    };
    nixpkgs.follows = "config/nixpkgs";
    home-manager.follows = "config/home-manager";
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
