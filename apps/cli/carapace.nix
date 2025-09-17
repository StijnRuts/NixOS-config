{
  programs.carapace = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableNushellIntegration = true;
  };

  persist.home = {
    directories = [
      ".cache/carapace"
    ];
  };
}
