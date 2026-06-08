{ pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.libqalculate
    pkgs.qalculate-qt
  ];

  persist.home = {
    directories = [
      ".config/qalculate"
    ];
  };
}
