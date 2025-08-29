{
  config,
  pkgs,
  me,
  ...
}:
{
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  environment.persistence."/persist" = {
    directories = [
      "/var/lib/libvirt"
    ];
  };
}
