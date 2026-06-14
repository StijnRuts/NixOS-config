{
  outputs.nixosModules.users =
    { config, lib, ... }:
    {
      options.custom.users = lib.mkOption {
          type = lib.types.attrsOf (
            lib.types.submodule {
              options = {
                fullname = lib.mkOption {
                  type = lib.types.str;
                };
                password = lib.mkOption {
                  type = lib.types.str;
                };
              };
            }
          );
          default = { };
        };
      config = {
        assertions = [
          {
            assertion = config.custom.users != { };
            message = "custom.users must contain at least one user.";
          }
        ];
        users.users = lib.mapAttrs (_: cfg: {
          isNormalUser = true;
          description = cfg.fullname;
          inherit (cfg) password;
        }) config.custom.users;
      };
    };
}
