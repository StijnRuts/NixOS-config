{ lib, pkgs, ... }:
{
  programs.firefox = lib.recursiveUpdate {
    enable = true;
    profiles.default = {
      settings = {
        "browser.newtabpage.activity-stream.topSitesRows" = 0;
      };
    };
    policies = {
      FirefoxHome.SponsoredTopSites = false;
      FirefoxSuggest.SponsoredSuggestions = false;
    };
  } (import ./firefox-settings.nix pkgs);

  persist.home = {
    directories = [
      ".mozilla"
      ".cache/mozilla"
    ];
  };
}
