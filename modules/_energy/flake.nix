{
  outputs = _: {
    nixosModules = [
      (
        {
          config,
          lib,
          me,
          ...
        }:
        {
          options.energy.profile = lib.mkOption {
            type = lib.types.enum [
              "default"
              "charge-limiting"
              "no-suspend"
            ];
            default = "default";
            description = "Sets your energy profile";
          };

          imports = [ ./charge-limiting.nix ];

          config =
            let
              chargeLimiting = config.energy.profile == "charge-limiting";
              noSuspend = config.energy.profile == "no-suspend";
            in
            {
              services.power-profiles-daemon.enable = !chargeLimiting;
              services.tlp.enable = chargeLimiting;

              home-manager.users.${me.username}.imports = [
                {
                  programs.plasma.powerdevil.AC.autoSuspend.action = lib.mkIf noSuspend "nothing";
                }
              ];
            };
        }
      )
    ];
  };
}
