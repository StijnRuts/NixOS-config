base: {
  outputs = inputs: {
    # TODO refactor
    nixosConfigurations = builtins.mapAttrs (
      _: config:
      inputs.nixpkgs.lib.nixosSystem (
        let
          args = base.args "x86_64-linux" inputs;
        in
        {
          system = config.system;
          specialArgs = args;
          modules = [
            config.disko
            config.hardware
            config.options.system
          ]
          ++ (base.nixosModules inputs)
          ++ [
            {
              home-manager = {
                extraSpecialArgs = args;
                users.${args.me.username}.imports = [ config.options.home ] ++ (base.homeModules inputs);
              };
            }
          ];
        }
      )
    ) base.hosts;
  };
}
