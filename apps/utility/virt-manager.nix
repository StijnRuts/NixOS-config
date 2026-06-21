{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkIf config.apps.utilities.enable {
    programs.virt-manager.enable = true;
    virtualisation.libvirtd.enable = true;

    networking.firewall.trustedInterfaces = [ "virbr0" ];
    users.users.stijn.extraGroups = [ "libvirtd" ];
    environment.systemPackages = with pkgs; [ dnsmasq ];

    persist.system = {
      directories = [
        "/var/lib/libvirt"
      ];
    };
  };
}
