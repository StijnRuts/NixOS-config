{ config, lib, ... }:
{
  options.apps.games.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable games";
  };

  config = lib.mkIf config.apps.games.enable {
    programs.steam = {
      enable = true;
    };

    allowUnfree = [
      "steam"
      "steam-unwrapped"
    ];

    persist.home = {
      directories = [
        "/.local/share/Steam"
      ];
    };
  };
}
