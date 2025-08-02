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
      "/var/lib/bluetooth"
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
        ".config/session"
        ".local/share/zoxide"
        ".cache/nvim"
        ".local/share/nvim"
        ".local/state/nvim"
        ".local/state/lazygit"
        ".mozilla"
        ".cache/mozilla"
        ".config/chromium"
        ".cache/chromium"
      ];
      files = [
        ".bash_history"
        ".zsh_history"
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
