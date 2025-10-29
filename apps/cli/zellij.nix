{
  programs.zellij = {
    enable = true;
    enableBashIntegration = false;
    enableZshIntegration = false; # Only enabled in WezTerm
    # enableNushellIntegration = false;
    attachExistingSession = false; # Set in WezTerm config
    settings = {
      pane_frames = false;
      show_startup_tips = false;
      simplified_ui = true;
      session_serialization = true;
      pane_viewport_serialization = true;
      scrollback_lines_to_serialize = 500;
      copy_on_select = false;
    };
  };

  catppuccin.zellij.enable = true;

  # https://github.com/zellij-org/zellij/blob/main/zellij-utils/assets/config/default.kdl
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
