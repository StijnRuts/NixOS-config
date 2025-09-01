{ me, ... }:
{
  programs.bash = {
    enable = true;
    enableCompletion = true;
  };

  home.persistence."/persist/home/${me.username}" = {
    allowOther = false;
    files = [
      ".bash_history"
    ];
  };
}
