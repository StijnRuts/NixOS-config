{ config, ... }:
{
  programs.virt-manager.enable = config.apps.utilities.enable;
  virtualisation.libvirtd.enable = config.apps.utilities.enable;

  persist.system = {
    directories = [
      "/var/lib/libvirt"
    ];
  };
}
