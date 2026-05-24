base: {
  outputs =
    inputs:
    let
      myOptions = import ./options.nix;
      args = base.args "x86_64-linux" inputs;
    in
    {
      # TODO refactor
      nixosConfigurations.X201 = inputs.nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = args;
        modules = [
          ./disko.nix
          ./hardware.nix
          myOptions.system
        ]
        ++ (base.nixosModules inputs)
        ++ [
          {
            home-manager = {
              extraSpecialArgs = args;
              users.${args.me.username}.imports = [ myOptions.home ] ++ (base.homeModules inputs);
            };
          }
        ];
      };
    };
}
