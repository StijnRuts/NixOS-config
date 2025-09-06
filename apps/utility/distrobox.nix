{ pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.distrobox
    pkgs.distrobox-tui
    pkgs.boxbuddy
  ];

  virtualisation.podman.enable = true;

  environment.etc."distrobox/distrobox.conf".text =
    let
      volumes = paths: builtins.concatStringsSep " " (map (path: "${path}:${path}:ro") paths);
    in
    ''
      container_additional_volumes="${
        volumes [
          "/nix/store"
          "/etc/profiles/per-user"
          "/etc/static/profiles/per-user"
        ]
      }"
    '';

  persist.home = {
    directories = [
      ".cache/distrobox"
      ".local/share/containers"
    ];
  };
}
