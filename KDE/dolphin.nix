{
  pkgs,
  lib,
  me,
  ...
}:
{
  programs.plasma = {
    configFile = {
      dolphinrc.General.RememberOpenedTabs = false; # Always open home directory
      dolphinrc.PreviewSettings.Plugins = "appimagethumbnail,audiothumbnail,blenderthumbnail,comicbookthumbnail,cursorthumbnail,djvuthumbnail,ebookthumbnail,exrthumbnail,fontthumbnail,imagethumbnail,jpegthumbnail,kraorathumbnail,windowsexethumbnail,windowsimagethumbnail,mobithumbnail,opendocumentthumbnail,gsthumbnail,rawthumbnail,svgthumbnail,ffmpegthumbs"; # No preview for directories
    };
  };

  home.file.".local/share/user-places.xbel".source = ./user-places.xbel; # Places sidebar

  # Set Dolphin to Details view
  home.file.".config/autostart/dolphin-xattrs.desktop".text = ''
    [Desktop Entry]
    Type=Application
    Name=Dolphin Detail view
    Exec=${pkgs.writeScript "dolphin-xattrs" ''
      #!/usr/bin/env bash
      ${lib.getExe' pkgs.coreutils "mkdir"} -p /home/${me.username}/.local/share/dolphin/view_properties/global
      ${lib.getExe' pkgs.attr "setfattr"} -n user.kde.fm.viewproperties#1 -v $'[Dolphin]\nViewMode=1' /home/${me.username}/.local/share/dolphin/view_properties/global
    ''}
  '';
}
