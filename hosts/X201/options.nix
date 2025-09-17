{
  system = {
    apps = {
      office.enable = false;
      graphics.enable = false;
      utilities.enable = true;
    };
    server = {
      syncthing.enable = true;
    };
    energy.profile = "charge-limiting";
    ollama.models = "light";
  };
  home = {
    systray.items = "laptop";
  };
}
