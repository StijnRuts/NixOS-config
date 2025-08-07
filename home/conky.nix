{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    conky
    nerd-fonts.ubuntu-mono
  ];

  systemd.user.services.conky = {
    Unit = {
      Description = "Conky - Lightweight system monitor";
      After = [ "graphical-session.target" ];
    };

    Service = {
      Restart = "always";
      RestartSec = "3";
      ExecStart = "/home/stijn/NixOS/home/conky/start.sh";
    };

    Install.WantedBy = [ "graphical-session.target" ];
  };
}
