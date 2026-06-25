{ pkgs, ... }:
{
  environment.packages = with pkgs; [
    procps
    killall
    diffutils
    findutils
    utillinux
    tzdata
    hostname
    man
    gnugrep
    gnupg
    gnused
    gnutar
    bzip2
    gzip
    xz
    zip
    unzip
  ];

  # Set up nix for flakes
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  time.timeZone = "Europe/Brussels";

  environment.etcBackupExtension = ".bak";

  android-integration = {
    am.enable = true;
    termux-open.enable = true;
    termux-open-url.enable = true;
    termux-reload-settings.enable = true;
    termux-setup-storage.enable = true;
    xdg-open.enable = true;
  };

  system.stateVersion = "24.05";

  # Configure home-manager
  home-manager = {
    config = ./home.nix;
    backupFileExtension = "hm-bak";
    useGlobalPkgs = true;
  };

  user.shell = "${pkgs.zsh}/bin/zsh";

  terminal.colors = {
    background = "#1e1e2e";
    foreground = "#cdd6f4";
    cursor = "#f5e0dc";
    color0 = "#45475a";
    color1 = "#f38ba8";
    color2 = "#a6e3a1";
    color3 = "#f9e2af";
    color4 = "#89b4fa";
    color5 = "#f5c2e7";
    color6 = "#94e2d5";
    color7 = "#a6adc8";
    color8 = "#585b70";
    color9 = "#f37799";
    color10 = "#89d88b";
    color11 = "#ebd391";
    color12 = "#74a8fc";
    color13 = "#f2aede";
    color14 = "#6bd7ca";
    color15 = "#bac2de";
  };

  terminal.font = "${pkgs.nerd-fonts.ubuntu}/share/fonts/truetype/NerdFonts/Ubuntu/UbuntuNerdFontPropo-Regular.ttf";
}
