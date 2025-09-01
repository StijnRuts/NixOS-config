{
  programs.eza = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    icons = "auto";
    git = true;
  };

  home.shellAliases = {
    "ll" = "ls -la";
  };
}
