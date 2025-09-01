{ pkgs, me, ... }:
{
  programs.chromium = {
    enable = true;
    package = pkgs.ungoogled-chromium;
  };

  home.persistence."/persist/home/${me.username}" = {
    allowOther = false;
    directories = [
      ".config/chromium"
      ".cache/chromium"
    ];
  };
}
