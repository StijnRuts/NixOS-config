{
  pkgs,
  pkgs-unstable,
  me,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    wezterm # To make the .desktop file show up, configured in home/wezterm.nix
    # firefox # Configured in home/firefox.nix
    ungoogled-chromium
    libreoffice-qt
    gimp
    krita
    inkscape
    beekeeper-studio
    pkgs-unstable.devenv
  ];

  nixpkgs.config.permittedInsecurePackages = [
    "beekeeper-studio-5.1.5"
  ];

  environment.persistence."/persist" = {
    users.${me.username} = {
      directories = [
        ".mozilla"
        ".cache/mozilla"
        ".config/chromium"
        ".cache/chromium"
        ".config/beekeeper-studio"
      ];
    };
  };
}
