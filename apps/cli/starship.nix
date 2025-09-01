{
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };

  home.file.".config/starship.toml".source = ./starship.toml;
}
