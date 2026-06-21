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
              modules = (builtins.attrValues self.nixosModules) ++ [
                self.diskoConfigurations.${h.host.hostname}
                (h.config or { })
              ];
            };

        diskoConfiguration = self.lib.mkDisko h.disko;
      };
    };
}
