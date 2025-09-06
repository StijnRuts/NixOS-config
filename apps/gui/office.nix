{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.apps.office.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable graphics apps";
  };

  config = lib.mkIf config.apps.office.enable {
    environment.systemPackages = [
      pkgs.libreoffice-qt
    ];
  };
}
