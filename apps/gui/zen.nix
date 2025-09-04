{
  config,
  lib,
  pkgs,
  me,
  ...
}:
{
  programs.zen-browser = lib.recursiveUpdate {
    enable = true;
    profiles.default = {
      settings = {
        "zen.welcome-screen.seen" = true;
        "zen.workspaces.continue-where-left-off" = true;
        "zen.view.compact.should-enable-at-startup" = true;
        "zen.view.show-newtab-button-top" = false;
        "zen.theme.content-element-separation" = 0;
      };
    };
  } (import ./firefox-settings.nix pkgs);

  defaultBrowser.package = config.programs.zen-browser.package;

  home.persistence."/persist/home/${me.username}" = {
    allowOther = false;
    directories = [
      ".zen"
      ".var/app/app.zen_browser.zen"
    ];
  };
}
