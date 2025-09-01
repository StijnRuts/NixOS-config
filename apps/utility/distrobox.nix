{ pkgs, me, ... }:
{
  environment.systemPackages = with pkgs; [
    distrobox
  ];

  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
  };

  environment.persistence."/persist" = {
    users.${me.username} = {
      directories = [
        ".cache/distrobox"
        ".local/share/containers"
      ];
    };
  };
}
