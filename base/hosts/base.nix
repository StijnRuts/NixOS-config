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
          inherit (config) system;
          specialArgs = args;
          modules = [
            config.hardware
            config.options
          ]
          ++ (base.nixosModules inputs);
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
