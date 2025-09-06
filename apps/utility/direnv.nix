{ config, ... }:
{
  programs.direnv = {
    inherit (config.apps.utilities) enable;
    enableBashIntegration = false;
    enableZshIntegration = false; # Only enabled in WezTerm
    nix-direnv.enable = true;
  };

  persist.home = {
    directories = [
      ".local/share/direnv"
    ];
  };
}
