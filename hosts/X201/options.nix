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
      nextcloud.enable = true;
    };
    systray.items = "laptop";
  };
}
