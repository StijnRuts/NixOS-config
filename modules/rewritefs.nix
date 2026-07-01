{
  outputs = _: {
    nixosModules.rewritefs = { lib, pkgs, ... }: {
      programs.fuse = {
        enable = true;
        userAllowOther = true;
      };

      boot.initrd.systemd.services.rewritefs-stijn = {
        description = "Rewrite dotfiles to .config";
        before = [ "sysroot.mount" ];
        wantedBy = [ "initrd.target" ];
        serviceConfig.Type = "oneshot";
        script = ''
          mkdir -p /mnt/rewritefs/stijn
          ${lib.getExe pkgs.rewritefs} -o config=${
            pkgs.writeText "rewritefs_config" ''
              m#^(?!\.)# .
              m#^\.(cache|config|local)# .
              m#^\.# .config/
            ''
          } /mnt/rewritefs/stijn /home/stijn
        '';
      };
    };
  };
}
