{
  programs.direnv = {
    enable = true;
    enableBashIntegration = false;
    enableZshIntegration = false; # Only enabled in WezTerm
    nix-direnv.enable = true;
  };

  persist.home = {
    directories = [
      ".local/share/direnv"
    ];
  };
}
