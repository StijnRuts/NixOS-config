{
  inputs = {
    impermanence.url = "github:nix-community/impermanence";
  };
  outputs = inputs: {
    modules = {
      nixos = [
        inputs.impermanence.nixosModules.impermanence
        (
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
        )
      ];
      home = [
        inputs.impermanence.homeManagerModules.impermanence
      ];
    };
  };
}
