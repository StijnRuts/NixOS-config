{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    distrobox
    distrobox-tui
    boxbuddy
  ];

  virtualisation.podman.enable = true;

  persist.home = {
    directories = [
      ".cache/distrobox"
      ".local/share/containers"
    ];
  };
}
