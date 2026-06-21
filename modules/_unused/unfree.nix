{ config, lib, ... }:
{
  options.allowUnfree = lib.mkOption {
    type = lib.types.listOf lib.types.str;
    description = "Enable unfree packages";
  };

  config = {
    nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) config.allowUnfree;
  };
}
