{
  pkgs,
  me,
  theme,
  ...
}:
{
  home.packages = with pkgs; [
    conky
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
      ExecStart = "/home/${me.username}/NixOS/home/conky/start.sh";
    };

    Install.WantedBy = [ "graphical-session.target" ];
  };
}
