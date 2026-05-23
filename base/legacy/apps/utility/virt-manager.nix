{ config, lib, ... }:
{
  config = lib.mkIf config.apps.utilities.enable {
    programs.virt-manager.enable = true;
    virtualisation.libvirtd.enable = true;

    persist.system = {
      directories = [
        "/var/lib/libvirt"
      ];
    };
  };
}
