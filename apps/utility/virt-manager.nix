{
  programs.virt-manager.enable = true;
  virtualisation.libvirtd.enable = true;

  persist.system = {
    directories = [
      "/var/lib/libvirt"
    ];
  };
}
