{
  outputs.nixosModules.networking = {
    networking.networkmanager.enable = true;

    networking.hostName = "X201"; # TODO

    users.users."stijn".extraGroups = [ "networkmanager" ]; # TODO
    # users.groups.networkmanager.members = config.custom.admins;
  };
}
