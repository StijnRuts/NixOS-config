{ theme, ... }:
{
  environment.systemPackages = [
    theme.fontPkg
  ];

  catppuccin = {
    flavor = theme.flavor;
    accent = theme.accent;
  };

  catppuccin.sddm = {
    enable = true;
    background = ./sddm-background.png;
    loginBackground = true;
    clockEnabled = false;
    userIcon = false;
    font = theme.font;
    fontSize = "16";
  };
}
