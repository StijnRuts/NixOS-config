{ pkgs-unstable, me, ... }:
{
  programs.atuin = {
    enable = true;
    package = pkgs-unstable.atuin.overrideAttrs (old: {
      patches = (old.patches or [ ]) ++ [
        ./atuin-color.patch
      ];
    });
    enableBashIntegration = true;
    enableZshIntegration = true;
    daemon.enable = true;
    settings = {
      show_help = false;
      show_tabs = false;
      show_preview = false;
      enter_accept = true;
      style = "auto";
      inline_height = 11;
      filter_mode = "global";
      filter_mode_shell_up_key_binding = "workspace";
      workspaces = true;
    };
  };

  catppuccin.atuin.enable = true;

  home.persistence."/persist/home/${me.username}" = {
    allowOther = false;
    directories = [
      ".local/share/atuin"
    ];
  };
}
