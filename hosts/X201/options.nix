{
  system = {
    apps = {
      office.enable = false;
      graphics.enable = false;
      utilities.enable = true;
    };
    energy.profile = "charge-limiting";
    ollama.models = "light";
  };
  home = {
    apps = {
      syncthing.enable = true;
    };
    systray.items = "laptop";
  };
}
