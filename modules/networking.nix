{
  outputs.nixosModules.networking =
    { config, host, ... }:
    {
      networking.networkmanager.enable = true;
      networking.hostName = host.hostname;
      users.groups.networkmanager.members = config.custom.admins;
    };
}
