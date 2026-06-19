{
  outputs.nixosModules.ly =
    { config, lib, ... }:
    {
      options.custom.ly.enable = lib.mkEnableOption "ly";
      config = lib.mkIf config.custom.ly.enable {
        services.displayManager.ly = {
          enable = true;
          settings = {
            default_input = "password";
            numlock = true;
          };
        };
      };
    };
}
