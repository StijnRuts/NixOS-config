{ config, pkgs, ... }:
{
  home.packages = [
    # Temporary: updated because of https://github.com/kando-menu/kando/pull/1312
    # Todo get from unstable
    (pkgs.callPackage ./kando-package.nix { })
  ];

  programs.niri.settings = {
    binds = with config.lib.niri.actions; {
      "Ctrl+Space".action.spawn-sh = "kando --menu 'Example Menu'";
    };
    window-rules = [
      {
        matches = [
          {
            app-id = "kando";
            title = "Kando Menu";
          }
        ];
        open-floating = true;
        border.enable = false;
        shadow.enable = false;
      }
    ];
  };

  /*
    Loading settings from /home/stijn/.config/kando/config.json
    Loading settings from /home/stijn/.config/kando/menus.json
    https://json-to-nix.pages.dev/

    It is perfectly fine to use the same shortcut ID for multiple menus.
    Use this in combination with the app-dependent menu feature to open
    different menus depending on the currently focused application!

    niri msg action
  */
}
