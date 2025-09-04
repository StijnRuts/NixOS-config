{
  programs.bash = {
    enable = true;
    enableCompletion = true;
  };

  persist.home = {
    files = [
      ".bash_history"
    ];
  };
}
