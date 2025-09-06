{
  system = {
    apps = {
      office.enable = true;
      graphics.enable = true;
      utilities.enable = true;
    };
    energy.profile = "no-suspend";
    ollama.models = "heavy";
  };
  home = {
    apps = {
      utilities.enable = true;
    };
    systray.items = "desktop";
  };
}
