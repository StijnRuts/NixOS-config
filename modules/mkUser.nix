{
  outputs =
    { self, ... }:
    {
      lib.mkUser = u: {
        nixosModule =
          {
            config,
            lib,
            ...
          }:
          {
            imports = [
              self.nixosModules.users
              (u.nixos.config or { })
            ]
            ++ (lib.lists.optional u.home-manager.enable self.nixosModules.home-manager);

            options.custom.${u.username}.enable = lib.mkEnableOption u.username;

            config = lib.mkIf config.custom.${u.username}.enable {
              custom.users.${u.username} = {
                inherit (u) fullname password;
                # hashedPasswordFile = config.age.secrets.hashed_password.path; # TODO
              };
              home-manager.users.${u.username} =
                lib.mkIf u.home-manager.enable
                  self.homeConfigurations.${u.username};

            };
          };
        homeConfiguration = {
          imports = [
            self.homeModules.home-manager
            (u.home-manager.config or { })
          ];
          config = {
            custom.home-manager.user = u.username;
          };
        };
      };
    };
}
