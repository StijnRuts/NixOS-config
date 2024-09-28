{ config, pkgs, lib, ... }:
{
  environment.persistence."/persist" = {
    enable = true;
    hideMounts = true;
    directories = [
      "/var/log"
      "/var/lib/bluetooth"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
      "/etc/NetworkManager/system-connections"
      "/etc/cups"
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
        { directory = ".local/share/kwalletd"; mode = "0700"; }
        ".local/share/zoxide"
      ];
    };
  };

  boot.initrd.postDeviceCommands = lib.mkAfter ''
    mkdir -p /btrfs_tmp
    mount /dev/disk/by-partlabel/disk-ssd-root /btrfs_tmp
    rm -rf /btrfs_tmp/rootfs
    btrfs subvolume create /btrfs_tmp/rootfs
  '';
}
