{ lib, pkgs, ... }:
{
  programs.nyxt = {
    enable = true;
    # config = ''
    #   TODO
    # '';
  };

  home.activation.nyxtSymlink = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    ln -sf ~/NixOS/apps/gui/nyxt ~/.config
  '';

  persist.home = {
    directories = [
      ".cache/nyxt"
      ".local/share/nyxt"
    ];
  };
}
