{ lib, pkgs, ... }:
{
  home.packages = [ pkgs.logseq ];

  home.activation.logseqSymlinks = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    ln -sf ~/NixOS/apps/gui/logseq/preferences.json .logseq/preferences.json
    ln -sf ~/NixOS/apps/gui/logseq/settings/logseq-catppuccin.json .logseq/settings/logseq-catppuccin.json
  '';

  persist.home = {
    directories = [
      ".logseq"
      ".config/Logseq"
    ];
  };
}
