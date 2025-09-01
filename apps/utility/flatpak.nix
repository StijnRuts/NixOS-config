{ me, ... }:
{
  services.flatpak.enable = true;

  environment.persistence."/persist" = {
    directories = [
      "/var/lib/flatpak"
    ];
    users.${me.username} = {
      directories = [
        ".local/share/flatpak"
      ];
    };
  };
}
