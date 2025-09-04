{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.defaultBrowser;
in
{
  options = {
    defaultBrowser = {
      package = lib.mkPackageOption pkgs "firefox" {
        default = null;
        extraDescription = "config.programs.firefox.package";
      };
    };
  };

  config = lib.mkIf (cfg.package != null) {
    programs.plasma.configFile = {
      "kdeglobals"."General"."BrowserApplication" = cfg.package.meta.desktopFileName;
    };

    xdg.mimeApps =
      let
        associations = builtins.listToAttrs (
          map
            (name: {
              inherit name;
              value = [ cfg.package.meta.desktopFileName ];
            })
            [
              "application/x-extension-shtml"
              "application/x-extension-xhtml"
              "application/x-extension-html"
              "application/x-extension-xht"
              "application/x-extension-htm"
              "x-scheme-handler/unknown"
              "x-scheme-handler/mailto"
              "x-scheme-handler/chrome"
              "x-scheme-handler/about"
              "x-scheme-handler/https"
              "x-scheme-handler/http"
              "application/xhtml+xml"
              "application/json"
              "text/html"
            ]
        );
      in
      {
        enable = true;
        associations.added = associations;
        defaultApplications = associations;
      };

    home.sessionVariables.DEFAULT_BROWSER = "${lib.getExe cfg.package}";
  };
}
