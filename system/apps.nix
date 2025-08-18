{
  config,
  pkgs,
  pkgs-unstable,
  me,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    wezterm # To make the .desktop file show up, configured in home/wezterm.nix
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
        ".config/beekeeper-studio"
      ];
    };
  };
}
