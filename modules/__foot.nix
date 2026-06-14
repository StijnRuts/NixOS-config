{ pkgs, theme, ... }:
{
  programs.foot = {
    enable = true;
    settings = {
      main = {
        include = "${pkgs.foot.themes}/share/foot/themes/catppuccin-mocha";
        font = "${theme.monofont}:size=11";
      };
    };
  };
}
