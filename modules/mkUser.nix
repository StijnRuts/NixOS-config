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

            options.custom.${u.user.username}.enable = lib.mkEnableOption u.user.username;

            config = lib.mkIf config.custom.${u.user.username}.enable {
              custom.users.${u.user.username} = {
                inherit (u.user) fullname password;
                # hashedPasswordFile = config.age.secrets.hashed_password.path; # TODO
              };
              home-manager.users.${u.user.username} =
                lib.mkIf u.home-manager.enable
                  self.homeConfigurations.${u.user.username};

            };
          };
        homeConfiguration = {
          imports = [
            self.homeModules.home-manager
            (u.home-manager.config or { })
          ];
          _module.args = {
            inherit (u) user;
          };
        };
      };
    };
}
