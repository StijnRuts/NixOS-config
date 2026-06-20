{
  outputs.homeModules.foot =
    { config, lib, ... }:
    {
      options.custom.foot.enable = lib.mkEnableOption "foot";
      config = lib.mkIf config.custom.foot.enable {
        programs.foot = {
          enable = true;
          settings = {
            main = {
             #include = "${pkgs.foot.themes}/share/foot/themes/catppuccin-mocha";
             #font = "${theme.monofont}:size=11";
            };
          };
        };
      };
    };
}
