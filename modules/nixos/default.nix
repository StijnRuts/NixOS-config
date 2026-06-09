{ lib, ... }:
{
  flakeOutputs = {
    nixosModules = lib.mkOption {
      type = lib.types.attrsOf lib.types.anything; #lib.types.submodule; # TODO
      default = { };
    };
    nixosConfigurations = lib.mkOption {
      type = lib.types.attrsOf lib.types.attrs;
      default = { };
    };
  };
}
