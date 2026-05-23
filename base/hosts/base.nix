{
  outputs =
    inputs@{ self, ... }:
    {
      # TODO refactor
      nixosConfigurations = {
        X201 = inputs.nixpkgs.lib.nixosSystem (import ./X201 self);
        T420 = inputs.nixpkgs.lib.nixosSystem (import ./T420 self);
        P520 = inputs.nixpkgs.lib.nixosSystem (import ./P520 self);
      };
    };
}
