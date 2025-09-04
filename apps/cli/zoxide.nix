{
  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };

  persist.home = {
    directories = [
      ".local/share/zoxide"
    ];
  };
}
