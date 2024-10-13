{ config, pkgs, ... }:
{
  time.timeZone = "Europe/Brussels";

  i18n.defaultLocale = "en_US.UTF-8";

  services.xserver.xkb = {
    layout = "be";
    variant = "";
  };

  console.keyMap = "be-latin1";
}
