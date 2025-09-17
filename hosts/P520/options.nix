{
  system = {
    apps = {
      office.enable = true;
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
