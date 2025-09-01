{ me, ... }:
{
  programs.direnv = {
    enable = true;
    enableBashIntegration = false;
    enableZshIntegration = false; # Only enabled in WezTerm
    nix-direnv.enable = true;
  };

  home.persistence."/persist/home/${me.username}" = {
    allowOther = false;
    directories = [
      ".local/share/direnv"
    ];
  };
}
