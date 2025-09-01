{ pkgs, lib, ... }:
{
  home.file.".local/share/kwin/scripts/automaximize".source = ./automaximize;

  home.activation."kwin_reconfigure" = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    ${pkgs.kdePackages.qttools}/bin/qdbus org.kde.KWin /KWin reconfigure
  '';

  programs.plasma.configFile.kwinrc.Plugins.automaximizeEnabled = true;
}
