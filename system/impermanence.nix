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
}
