{
  config,
  pkgs,
  lib,
  ...
}:
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
        ".local/share/Trash"
        "NixOS"
        {
          directory = ".ssh";
          mode = "0700";
        }
        {
          directory = ".local/share/kwalletd";
          mode = "0700";
        }
      ];
    };
  };

  fileSystems."/persist".neededForBoot = true;

  boot.initrd.postDeviceCommands = pkgs.lib.mkBefore ''
    mkdir /mnt
    mount -o subvol=/ /dev/mapper/encrypted_maindisk /mnt
    rm -rf /mnt/rootfs
    btrfs subvolume create /mnt/rootfs
  '';
}
