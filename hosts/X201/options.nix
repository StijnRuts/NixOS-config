{
  system = {
    apps = {
      office.enable = false;
      graphics.enable = false;
    };
    energy.profile = "charge-limiting";
    ollama.models = "light";
  };
  home = {
    systray.items = "laptop";
  };
}
