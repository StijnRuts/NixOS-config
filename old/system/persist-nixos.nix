{
  config,
  lib,
  me,
  ...
}:
let
  cfg = config.persist;
  inherit (lib) mkOption types;
in
{
  options = {
    persist = {
      system = {
        files = mkOption {
          type = types.listOf types.unspecified;
          default = [ ];
        };
        directories = mkOption {
          type = types.listOf types.unspecified;
          default = [ ];
        };
      };
      home = {
        files = mkOption {
          type = types.listOf types.unspecified;
          default = [ ];
        };
        directories = mkOption {
          type = types.listOf types.unspecified;
          default = [ ];
        };
      };
    };
  };

  config = {
    environment.persistence."/persist" = cfg.system // {
      users.${me.username} = cfg.home;
    };
  };
}
