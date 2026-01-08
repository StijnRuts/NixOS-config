{ config, pkgs, ... }:
{
  programs.atuin = {
    enable = true;
    package = pkgs.atuin.overrideAttrs (old: {
      patches = (old.patches or [ ]) ++ [
        ./atuin-color.patch # Don't highlight the selected command as an error
      ];
    });
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableNushellIntegration = true;
    daemon.enable = true;
    settings = {
      sync_address = "https://atuin.P520.local";
      session_path = config.age.secrets.atuin_session.path;
      key_path = config.age.secrets.atuin_key.path;
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

  age.secrets = {
    atuin_session.file = ../../secrets/atuin/session.age;
    atuin_key.file = ../../secrets/atuin/key.age;
  };

  catppuccin.atuin.enable = true;

  persist.home = {
    directories = [
      ".local/share/atuin"
    ];
  };
}
