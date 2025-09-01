{ lib, theme, ... }:
{
  # used by devenv

  home.file = {
    ".config/process-compose/shortcuts.yaml".text = lib.generators.toYAML { } {
      shortcuts.quit.shortcut = "q";
    };
    ".config/process-compose/settings.yaml".text = lib.generators.toYAML { } {
      disable_exit_confirmation = true;
      theme = "Catppuccin ${theme.Flavor}";
    };
  };

  # TODO: Wait for PR: https://github.com/nix-community/home-manager/pull/7736
  /*
    programs.process-compose = {
      enable = true;
      settings = {
        disable_exit_confirmation = true;
        theme = "Catppuccin ${theme.Flavor}";
      };
      shortcuts = {
        quit.shortcut = "q";
      };
    };
  */
}
