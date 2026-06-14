{ me, ... }:
{
  virtualisation.incus.enable = true;
  networking.nftables.enable = true;

  users.users.${me.username}.extraGroups = [ "incus-admin" ];

  virtualisation.incus.preseed = {
    projects = [ ];
    profiles = [
      {
        name = "default";
        description = "Incus default profile";
        project = "default";
        devices = {
          eth0 = {
            type = "nic";
            name = "eth0";
            network = "incusbr0";
          };
          root = {
            type = "disk";
            pool = "default";
            path = "/";
          };
        };
      }
    ];
    networks = [
      {
        name = "incusbr0";
        type = "bridge";
        description = "Incus network bridge";
        project = "default";
        config = {
          "ipv4.address" = "auto";
          #"ipv4.nat" = "true";
          "ipv6.address" = "auto";
          #"ipv6.nat" = "true";
        };
      }
    ];
    storage_pools = [
      {
        name = "default";
        description = "Incus storage pool";
        driver = "btrfs";
        config.source = "/var/lib/incus/storage-pools/default";
      }
    ];
    storage_volumes = [ ];
    certificates = [ ];
    cluster_groups = [ ];
    cluster = null;
    config = {
      "images.auto_update_interval" = "0";
    };
  };

  networking.firewall.interfaces.incusbr0 = {
    allowedTCPPorts = [
      53
      67
    ];
    allowedUDPPorts = [
      53
      67
    ];
  };

  persist.system = {
    directories = [
      "/var/lib/incus"
    ];
  };
}
