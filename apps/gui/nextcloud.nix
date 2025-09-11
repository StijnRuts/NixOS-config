{ config, lib, ... }:
{
  options.apps.nextcloud.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable Nextcloud client";
  };

  config = lib.mkIf config.apps.nextcloud.enable {
    services.nextcloud-client = {
      enable = true;
      startInBackground = true;
    };

    home.file =
      let
        syncExclude = ''
          .git
          .devenv
          vendor
          node_modules
          bower_components
          .pulp-cache
          output
          output-es
          .psc-package
          .spago
        '';
      in
      {
        "Documents/.sync-exclude.lst".text = syncExclude;
        "Downloads/.sync-exclude.lst".text = syncExclude;
        "Music/.sync-exclude.lst".text = syncExclude;
        "Pictures/.sync-exclude.lst".text = syncExclude;
        "Projects/.sync-exclude.lst".text = syncExclude;
        "Public/.sync-exclude.lst".text = syncExclude;
        "Templates/.sync-exclude.lst".text = syncExclude;
        "Videos/.sync-exclude.lst".text = syncExclude;
      };

    persist.home = {
      directories = [
        ".config/Nextcloud"
      ];
    };
  };
}
