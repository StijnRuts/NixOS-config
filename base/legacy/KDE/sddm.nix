{ me, theme, ... }:
{
  services.displayManager.sddm.enable = true;

  # Copy KDE display config to SDDM
  system.activationScripts.sddmCopyDisplayConfig.text = ''
    source_file="/home/${me.username}/.config/kwinoutputconfig.json"
    dest_file="/var/lib/sddm/.config/kwinoutputconfig.json"

    if [ -f "$source_file" ]; then
      cp "$source_file" "$dest_file"
      chown sddm:sddm "$dest_file"
    fi
  '';

  catppuccin.sddm = {
    enable = true;
    background = ./sddm-background.png;
    loginBackground = true;
    clockEnabled = false;
    userIcon = false;
    inherit (theme) font;
    fontSize = "16";
  };

  persist.system = {
    directories = [
      "/var/lib/sddm"
    ];
  };
}
