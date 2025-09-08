{ pkgs, me, ... }:
{
  services.desktopManager.plasma6.enable = true;
  programs.kdeconnect.enable = true;

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    baloo
    baloo-widgets
  ];

  home-manager.users.${me.username}.imports = [
    {
      home.file."Projects/.directory".text = ''
        [Desktop Entry]
        Icon=folder-code
      '';
    }
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
