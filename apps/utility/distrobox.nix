{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    distrobox
  ];

  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
  };

  persist.home = {
    directories = [
      ".cache/distrobox"
      ".local/share/containers"
    ];
  };
}
