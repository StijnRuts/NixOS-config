{
  pkgs,
  me,
  theme,
  ...
}:
{
  home.packages = [
    pkgs.conky
    theme.monofontPkg
  ];

  home.sessionVariables.CONKY_FONT = theme.monofont;

  # systemctl --user restart conky.service
  systemd.user.services.conky = {
    Unit = {
      Description = "Conky - Lightweight system monitor";
      After = [ "graphical-session.target" ];
    };

    Service = {
      Restart = "always";
      RestartSec = "3";
      ExecStart = "/home/${me.username}/NixOS/apps/gui/conky/start.sh";
    };

    Install.WantedBy = [ "graphical-session.target" ];
  };
}
