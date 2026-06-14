{
  outputs.nixosModules.admins =
    { config, lib, ... }:
    {
      options.custom.admins = lib.mkOption {
        type = lib.types.nonEmptyListOf lib.types.str;
        default = [ ];
      };
      config = {
        users.groups.wheel.members = config.custom.admins;
      };
    };
}
