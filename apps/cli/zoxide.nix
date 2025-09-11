{
  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableNushellIntegration = true;
  };

  persist.home = {
    directories = [
      ".local/share/zoxide"
    ];
  };
}
