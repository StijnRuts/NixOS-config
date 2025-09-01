{ me, ... }:
{
  services.desktopManager.plasma6.enable = true;
  programs.kdeconnect.enable = true;

  environment.persistence."/persist" = {
    users.${me.username} = {
      directories = [
        "Desktop"
        "Documents"
        "Downloads"
        "Music"
        "Pictures"
        "Public"
        "Templates"
        "Videos"
        "NixOS"
        ".local/share/Trash"
        ".config/kdeconnect"
        {
          directory = ".local/share/kwalletd";
          mode = "0700";
        }
      ];
    };
  };
}
