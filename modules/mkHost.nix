{
  outputs =
    { self, ... }@inputs:
    {
      lib.mkHost = h: {
        nixosConfiguration =
          inputs."nixpkgs-${builtins.replaceStrings [ "." ] [ "-" ] h.host.nixosVersion}".lib.nixosSystem
            {
              inherit (h.host) system;
              specialArgs = {
                inherit (h) host;
              };
              modules = [
                self.nixosModules.nix
                self.nixosModules.disko
                self.diskoConfigurations.${h.host.hostname}
                (h.config or { })
              ];
            };

        diskoConfiguration = self.lib.mkDisko h.disko;
      };
    };
}
