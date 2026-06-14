{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.apps.graphics.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable graphics apps";
  };

  config = lib.mkIf config.apps.graphics.enable {
    environment.systemPackages = [
      pkgs.gimp
      pkgs.krita
      pkgs.inkscape
    ];
  };
}
