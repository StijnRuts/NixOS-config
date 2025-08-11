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
    devenv
    distrobox
    beekeeper-studio
  ];

  # For Distrobox
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
  };

  nixpkgs.config.permittedInsecurePackages = [
    "beekeeper-studio-5.1.5"
  ];

  environment.persistence."/persist" = {
    users.${me.username} = {
      directories = [
        ".cache/distrobox"
        ".local/share/containers" # podman
        ".config/beekeeper-studio"
      ];
    };
  };
}
