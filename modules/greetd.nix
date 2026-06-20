{
  outputs.nixosModules.greetd =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      options.custom.greetd.enable = lib.mkEnableOption "greetd";
      config = lib.mkIf config.custom.greetd.enable {
        services.greetd = {
          enable = true;
          useTextGreeter = true;
         #settings = {
         #  default_session = {
         #    command = "${pkgs.greetd}/bin/agreety";
         #  };
         #};
        };
      };
    };
}
