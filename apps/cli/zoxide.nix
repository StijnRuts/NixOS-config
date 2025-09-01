{ me, ... }:
{
  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };

  home.persistence."/persist/home/${me.username}" = {
    allowOther = false;
    directories = [
      ".local/share/zoxide"
    ];
  };
}
