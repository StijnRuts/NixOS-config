{ me, ... }:
{
  # TODO: check https://github.com/NixOS/nixpkgs/pull/347222
  # TODO: https://github.com/0xc000022070/zen-browser-flake

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
