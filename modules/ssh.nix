{
  outputs = _: {
    homeModules.ssh = { config, lib, ... }: {
      options.custom.ssh.enable = lib.mkEnableOption "ssh";
      config = lib.mkIf config.custom.ssh.enable {
        custom.persist.directories = [ ".ssh" ];
      };
    };
  };
}
