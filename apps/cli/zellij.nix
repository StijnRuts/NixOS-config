{
  programs.zellij = {
    enable = true;
    enableBashIntegration = false;
    enableZshIntegration = false; # Only enabled in WezTerm
    # enableNushellIntegration = false;
    attachExistingSession = false; # Set in WezTerm config
    settings = {
      simplified_ui = true;
      pane_frames = false;
      status_bar = true;
      tab_bar = true;
      show_startup_tips = false;
      session_serialization = true;
      pane_viewport_serialization = true;
      scrollback_lines_to_serialize = 500;
      copy_on_select = false;
    };
    layouts = {
      default = {
        layout = {
          _children = [
            {
              default_tab_template = {
                _children = [
                  {
                    pane = {
                      size = 1;
                      borderless = true;
                      plugin = {
                        location = "zellij:tab-bar";
                      };
                    };
                  }
                  { children = { }; }
                  {
                    pane = {
                      size = 1;
                      borderless = true;
                      plugin = {
                        location = "zellij:status-bar";
                      };
                    };
                  }
                ];
              };
            }
          ]
          ++
            builtins.map
              (
                { name, command }:
                {
                  tab = {
                    _props = { inherit name; };
                    _children = [
                      {
                        pane = {
                          command = "zsh";
                          args = [
                            "-c"
                            "${command} ; exec zsh -i"
                          ];
                        };
                      }
                    ];
                  };
                }
              )
              [
                {
                  name = "Git";
                  command = "lazygit";
                }
                {
                  name = "CLI";
                  command = "devenv shell";
                }
                {
                  name = "Vim";
                  command = "nvim .";
                }
                {
                  name = "Server";
                  command = "devenv up";
                }
              ];
        };
      };
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
