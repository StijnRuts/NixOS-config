{
  system = {
    apps = {
      office.enable = true;
      graphics.enable = true;
    };
    energy.profile = "no-suspend";
    ollama.models = "heavy";
  };
  home = {
    systray.items = "desktop";
  };
}
