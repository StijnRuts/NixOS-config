{ me, ... }:
{
  services.flatpak.enable = true;

  services.flatpak.packages = [
    "app.zen_browser.zen"
  ];

  environment.persistence."/persist" = {
    users.${me.username} = {
      directories = [
        ".zen"
        ".var/app/app.zen_browser.zen"
      ];
    };
  };
}
