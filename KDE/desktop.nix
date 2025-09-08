{ pkgs, ... }:
{
  services.desktopManager.plasma6.enable = true;
  programs.kdeconnect.enable = true;

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    baloo
    baloo-widgets
  ];

  persist.home = {
    directories = [
      ".config/kdeconnect"
      {
        directory = ".local/share/kwalletd";
        mode = "0700";
      }
    ];
  };
}
