{
  system = {
    base.disko.profile = "X201";
    apps = {
      office.enable = true;
      games.enable = false;
      graphics.enable = true;
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
