{ config, lib, ... }:
{
  options = {
    hosts = lib.mkOption {
      type = lib.types.anything; # TODO
      default = { };
    };
  };
  config = {
    outputs = inputs: {
      nixosConfigurations = {
        # TODO
        X201 = inputs.nixpkgs.lib.nixosSystem {
          inherit (config.hosts.X201) system;
          modules = [ config.hosts.X201.hostConfig ];
          extraArgs = {
            hostsKey = "X201";
          };
        };
      };
    };
  };
}
