{
  system = {
    apps = {
      office.enable = true;
      graphics.enable = true;
      utilities.enable = true;
    };
    server = {
      atuin.enable = true;
      nextcloud.enable = true;
    };
    energy.profile = "no-suspend";
    ollama.models = "heavy";
  };
  home = {
    apps = {
      nextcloud.enable = true;
    };
    systray.items = "desktop";
  };
}
