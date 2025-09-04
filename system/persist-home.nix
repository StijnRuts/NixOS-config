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
      home = {
        directories = mkOption {
          type = types.listOf types.unspecified;
          default = [ ];
        };
        files = mkOption {
          type = types.listOf types.unspecified;
          default = [ ];
        };
      };
    };
  };

  config = {
    home.persistence."/persist/home/${me.username}" = {
      allowOther = false;
    }
    // cfg.home;
  };
}
