{ me, ... }:
{
  services.flatpak.enable = true;

  services.flatpak.packages = [
    "app.zen_browser.zen"
  ];

  environment.persistence."/persist" = {
    directories = [
      "/var/lib/flatpak"
    ];
    users.${me.username} = {
      directories = [
        ".local/share/flatpak"
        ".zen"
        ".var/app/app.zen_browser.zen"
      ];
    };
  };
}
