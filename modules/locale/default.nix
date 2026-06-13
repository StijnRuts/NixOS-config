{
  outputs.nixosModules.locale = {
    services.xserver.xkb = {
      layout = "be";
      variant = "";
    };
    console.keyMap = "be-latin1";

    time.timeZone = "Europe/Brussels";

    i18n.defaultLocale = "en_US.UTF-8";
  };
}
