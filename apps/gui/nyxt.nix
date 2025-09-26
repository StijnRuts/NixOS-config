{ lib, pkgs, ... }:
{
  # Temporary. This is in Home Manager unstable.
  # programs.nyxt = {
  #   enable = true;
  #   config = ''
  #     TODO
  #   '';
  # };

  home.packages = [ pkgs.nyxt ];

  home.activation.nyxtSymlink = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    ln -sf ~/NixOS/apps/gui/nyxt ~/.config/nyxt
  '';

  persist.home = {
    directories = [
      ".cache/nyxt"
      ".local/share/nyxt"
    ];
  };
}
