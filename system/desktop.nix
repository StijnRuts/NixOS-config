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

  # Copy KDE display config to SDDM
  system.activationScripts.sddmCopyDisplayConfig.text = ''
    source_file="/home/${me.username}/.config/kwinoutputconfig.json"
    dest_file="/var/lib/sddm/.config/kwinoutputconfig.json"

    if [ -f "$source_file" ]; then
      cp "$source_file" "$dest_file"
      chown sddm:sddm "$dest_file"
    fi
  '';

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
