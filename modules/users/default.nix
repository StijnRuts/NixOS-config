{ config, lib, ... }:
{
  options = {
    users = lib.mkOption {
      type = lib.types.anything; # TODO
      default = { };
    };
  };
  config = {
    outputs = {
      nixosModules.users.stijn = {
        options.users.stijn.enable = lib.mkEnableOption "users.stijn";
        config = lib.mkIf config.users.stijn.enable {
          imports = [
            config.users.stijn.hostConfig
          ];
          users.users."stijn" = {
            isNormalUser = true;
            description = config.users.stijn.name;
            password = "fake";
            extraGroups = [ "wheel" ];
          };
        };
      };
    };
  };
}
