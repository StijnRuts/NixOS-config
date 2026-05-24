{
  system = {
    base.disko.profile = "T420";
    apps = {
      office.enable = true;
      games.enable = true;
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
