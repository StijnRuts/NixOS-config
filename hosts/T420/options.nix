{
  system = {
    apps = {
      office.enable = true;
      graphics.enable = true;
      utilities.enable = true;
    };
    energy.profile = "charge-limiting";
    ollama.models = "light";
  };
  home = {
    systray.items = "laptop";
  };
}
