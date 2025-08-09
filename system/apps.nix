{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
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
}
