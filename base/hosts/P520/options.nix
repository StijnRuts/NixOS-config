{
  base.disko.profile = "P520";
  # base.users.stijn.enable = true;
  apps = {
    office.enable = true;
    games.enable = true;
    graphics.enable = true;
    utilities.enable = true;
  };
  server = {
    atuin.enable = true;
    tarsnap.enable = true;
  };
  energy.profile = "no-suspend";
  ollama.models = "heavy";
}
