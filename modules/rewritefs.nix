{
  outputs = _: {
    nixosModules.rewritefs =
      { pkgs, ... }:
      {
        programs.fuse = {
          enable = true;
          userAllowOther = true;
        };

        boot.initrd = {
          kernelModules = [ "fuse" ];
          systemd.packages = [ pkgs.rewritefs ];
        };

        boot.initrd.systemd.services.rewritefs-stijn = {
          description = "Rewrite dotfiles to .config";
          before = [ "sysroot.mount" ];
          wantedBy = [ "initrd.target" ];
          serviceConfig.Type = "oneshot";
          script = ''
            mkdir -p /mnt/rewritefs/stijn
            rewritefs -o config=${pkgs.writeText "rewritefs_config" ''
              m#^(?!\.)# .
              m#^\.(cache|config|local)# .
              m#^\.# .config/
            ''} /mnt/rewritefs/stijn /home/stijn
          '';
        };
      };
  };
}
