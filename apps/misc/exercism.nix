{ pkgs, ... }:
{
  home.packages = [
    pkgs.exercism
  ];

  persist.home = {
    directories = [
      ".config/exercism"
    ];
  };
}

