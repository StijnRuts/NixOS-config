{
  inputs = {
    impermanence = {
      url = "github:nix-community/impermanence";
      inputs.nixpkgs.follows = "nixpkgs-current";
      inputs.home-manager.follows = "home-manager-current";
    };
  };

  outputs = inputs: {
    nixosModules.impermanence =
      { config, lib, ... }:
      {
        imports = [ inputs.impermanence.nixosModules.impermanence ];

        options.custom = {
          impermanence.enable = lib.mkEnableOption "impermanence";
          persist = {
            files = lib.mkOption {
              type = lib.types.listOf lib.types.unspecified;
              default = [ ];
            };
            directories = lib.mkOption {
              type = lib.types.listOf lib.types.unspecified;
              default = [ ];
            };
          };
        };

        config = lib.mkIf config.custom.impermanence.enable {
          environment.persistence."/persist" = {
            enable = true;
            hideMounts = true;
            inherit (config.custom.persist) files directories;
          };

          fileSystems."/persist".neededForBoot = true;

          boot.initrd.systemd.services.impermanence = {
            description = "Restore root to empty state";
            before = [ "sysroot.mount" ];
            wantedBy = [ "initrd.target" ];
            serviceConfig.Type = "oneshot";
            script = ''
              mkdir -p /mnt
              mount -o subvol=/ /dev/mapper/encrypted_maindisk /mnt
              btrfs subvolume delete /mnt/rootfs 2>/dev/null || true
              btrfs subvolume create /mnt/rootfs
            '';
          };

          # TODO move
          custom.persist = {
            directories = [
              "/var/log"
              "/var/lib/nixos"
              "/var/lib/systemd/coredump"
            ];
          };
        };
      };

    homeModules.impermanence =
      {
        config,
        lib,
        nixosConfig,
        ...
      }:
      {
        options.custom = {
          persist = {
            files = lib.mkOption {
              type = lib.types.listOf lib.types.unspecified;
              default = [ ];
            };
            directories = lib.mkOption {
              type = lib.types.listOf lib.types.unspecified;
              default = [ ];
            };
          };
        };

        config = lib.mkIf nixosConfig.custom.impermanence.enable {
          home.persistence."/persist" = {
            inherit (config.custom.persist) files directories;
          };

          # TODO move
          custom.persist = {
            directories = [
              "Desktop"
              "Documents"
              "Downloads"
              "Music"
              "NixOS"
              "Pictures"
              "Projects"
              "Public"
              "Templates"
              "Videos"
              ".local/share/Trash"
            ];
          };
        };
      };
  };
}
