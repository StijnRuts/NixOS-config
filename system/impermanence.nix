{ lib, me, ... }:
{
  environment.persistence."/persist" = {
    enable = true;
    hideMounts = true;
  };

  fileSystems."/persist".neededForBoot = true;

  boot.initrd.postDeviceCommands = lib.mkBefore ''
    mkdir /mnt
    mount -o subvol=/ /dev/mapper/encrypted_maindisk /mnt
    rm -rf /mnt/rootfs
    btrfs subvolume create /mnt/rootfs
  '';

  environment.persistence."/persist" = {
    users.${me.username} = {
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
        ".local/share/Trash"
      ];
    };
    directories = [
      "/var/log"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
    ];
  };
}
