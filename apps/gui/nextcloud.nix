{ config, lib, ... }:
{
  options.apps.nextcloud.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable Nextcloud client";
  };

  config = {
    services.nextcloud-client = {
      inherit (config.apps.nextcloud) enable;
      startInBackground = true;
    };
  };
}
