{
  services.desktopManager.plasma6.enable = true;
  programs.kdeconnect.enable = true;

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
