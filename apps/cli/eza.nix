{
  programs.eza = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableNushellIntegration = false;
    icons = "auto";
    git = true;
  };

  home.shellAliases = {
    "ll" = "ls -la";
  };
}
