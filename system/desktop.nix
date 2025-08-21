{
  config,
  pkgs,
  me,
  ...
}:
{
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
  programs.kdeconnect.enable = true;

  environment.systemPackages = with pkgs; [
    ubuntu_font_family
  ];

  catppuccin.sddm = {
    enable = true;
    accent = "yellow";
    background = ./sddm-background.png;
    loginBackground = true;
    clockEnabled = false;
    userIcon = false;
    font = "Ubuntu";
    fontSize = "16";
  };

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
    directories = [
      "/var/lib/sddm"
    ];
  };
}
