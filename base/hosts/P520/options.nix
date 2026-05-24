{
  system = {
    base.disko.profile = "P520";
    apps = {
      office.enable = true;
      games.enable = true;
      graphics.enable = true;
      utilities.enable = true;
    };
    server = {
      atuin.enable = true;
      tarsnap.enable = true;
    };
    energy.profile = "no-suspend";
    ollama.models = "heavy";
  };
  home = {
    apps = {
      syncthing.enable = true;
    };
    systray.items = "desktop";
  };
}
