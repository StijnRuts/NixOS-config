{
  programs.carapace = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };

  persist.home = {
    directories = [
      "/home/stijn/.cache/carapace"
    ];
  };
}
