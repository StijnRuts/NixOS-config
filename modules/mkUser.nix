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
              (u.nixos.config or { })
            ];

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
          imports = (builtins.attrValues self.homeModules) ++ [
            (u.home-manager.config or { })
          ];
          _module.args = {
            inherit (u) user;
          };
        };
      };
    };
}
