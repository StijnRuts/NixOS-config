{
  outputs.nixosModules.$1 =
    { config, lib, ... }:
    {
      options.custom.$1.enable = lib.mkEnableOption "$1";
      config = lib.mkIf config.custom.$1.enable {
        $2
      };
    };
}
