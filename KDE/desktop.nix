{ me, ... }:
{
  services.desktopManager.plasma6.enable = true;
  programs.kdeconnect.enable = true;

  environment.persistence."/persist" = {
    users.${me.username} = {
      directories = [
        ".config/kdeconnect"
        {
          directory = ".local/share/kwalletd";
          mode = "0700";
        }
      ];
    };
  };
}
