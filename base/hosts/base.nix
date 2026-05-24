base: {
  args = _: _: {};
  nixosModules = _: [];
  outputs = inputs: {
    args = base.args "x86_64-linux" inputs;
    nixosModules = base.nixosModules inputs;
    # TODO refactor
    nixosConfigurations = builtins.mapAttrs (
      _: config:
      inputs.nixpkgs.lib.nixosSystem (
        let
          args = base.args config.system inputs;
        in
        {
          system = config.system;
          specialArgs = args;
          modules = [
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
    ) {
      # TODO auto import
      X201 = import ./X201/host.nix;
      T420 = import ./T420/host.nix;
      P520 = import ./P520/host.nix;
    };
  };
}
