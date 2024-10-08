{ config, pkgs, lib, ... }:
{
  environment.persistence."/persist" = {
    enable = true;
    hideMounts = true;
    directories = [
      "/var/log"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
      "/etc/NetworkManager/system-connections"
    ];
    users.stijn = {
      directories = [
        "Desktop"
        "Documents"
        "Downloads"
        "Music"
        "Pictures"
        "Public"
        "Templates"
        "Videos"
        "NixOS"
        { directory = ".ssh"; mode = "0700"; }
      ];
    };
  };

  boot.initrd.postDeviceCommands = lib.mkAfter ''
    mkdir -p /btrfs_tmp
    mount /dev/disk/by-partlabel/disk-maindisk-root /btrfs_tmp
    rm -rf /btrfs_tmp/rootfs
    btrfs subvolume create /btrfs_tmp/rootfs
  '';
}
