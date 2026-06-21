{
  outputs.nixosModules.networking =
    {
      config,
      host,
      lib,
      ...
    }:
    {
      options.custom.networking.enable = lib.mkEnableOption "networking";
      config = lib.mkIf config.custom.networking.enable {
        networking = {
          networkmanager.enable = true;
          useDHCP = lib.mkDefault true;
          hostName = host.hostname;
        };

        users.groups.networkmanager.members = config.custom.admins;
      };
    };
}
