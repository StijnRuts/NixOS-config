{ pkgs, ... }:
{
  programs.yazi = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableNushellIntegration = true;
    shellWrapperName = "y";
    settings = {
      mgr = {
        show_hidden = true;
        ratio = [1 3 4];
      };
      plugin = {
        prepend_previewers = [
          {
            mime = "application/json";
            run = ''piper -- bat -p --color=always --language=json "$1"'';
          }
        ];
      };
    };
    plugins = with pkgs.yaziPlugins; {
      inherit piper;
    };
    keymap = {
      mgr.prepend_keymap = [
        {
          on = [ "<Space>" ];
          run = "toggle"; # Don't move down after selecting
        }
      ];
    };
  };

  catppuccin.yazi.enable = true;
  catppuccin.yazi.accent = "blue";
}
