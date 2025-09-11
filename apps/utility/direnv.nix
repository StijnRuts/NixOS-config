{ config, lib, me, ... }:
{
  config = lib.mkIf config.apps.utilities.enable {
    home-manager.users.${me.username}.imports = [
      {
        programs.direnv = {
          enable = true;
          enableBashIntegration = false;
          enableZshIntegration = false; # Only enabled in WezTerm
          enableNushellIntegration = false;
          nix-direnv.enable = true;
        };

        persist.home = {
          directories = [
            ".local/share/direnv"
          ];
        };
      }
    ];
  };
}
