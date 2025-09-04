{
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  persist.system = {
    directories = [
      "/var/lib/libvirt"
    ];
  };
}
