{
  config,
  pkgs,
  me,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    wezterm # To make the .desktop file show up, configured in shell.nix
    libreoffice-qt
    gimp
    krita
    inkscape
    beekeeper-studio
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
