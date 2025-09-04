{
  programs.zellij = {
    enable = true;
    enableBashIntegration = false;
    enableZshIntegration = false; # Only enabled in WezTerm
    attachExistingSession = false; # Set in WezTerm config
    settings = {
      pane_frames = false;
      show_startup_tips = false;
      simplified_ui = true;
      session_serialization = true;
      pane_viewport_serialization = true;
      scrollback_lines_to_serialize = 500;
    };
  };

  catppuccin.zellij.enable = true;

  # Change ctrl keybinds to alt
  xdg.configFile."zellij/config.kdl" = {
    text = builtins.readFile ./zellij.kdl;
  };

  persist.home = {
    directories = [
      ".cache/zellij"
    ];
  };
}
