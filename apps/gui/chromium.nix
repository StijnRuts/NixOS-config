{ pkgs, ... }:
{
  programs.chromium = {
    enable = true;
    package = pkgs.ungoogled-chromium;
  };

  persist.home = {
    directories = [
      ".config/chromium"
      ".cache/chromium"
    ];
  };
}
