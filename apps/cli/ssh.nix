{ me, ... }:
{
  home.persistence."/persist/home/${me.username}" = {
    allowOther = false;
    directories = [
      ".ssh"
    ];
  };
}
