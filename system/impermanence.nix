{ lib, ... }:
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

  persist.home = {
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
  persist.system = {
    directories = [
      "/var/log"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
    ];
  };
}
