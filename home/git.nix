{ config, pkgs, ... }:
{
  programs.git = {
    enable = true;
    userEmail = "git@stijnruts.be";
    userName = "Stijn Ruts";
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
    };
  };
  programs.git.delta.enable = true;
  programs.lazygit.enable = true;

  home.shellAliases = {
    "gs" = "git status";
    "ga" = "git add";
    "gaa" = "git add --all";
    "gap" = "git add --patch";
    "gd" = "git diff";
    "gdc" = "git diff --cached";
    "gc" = "git commit";
    "gcm" = "git commit --message";
    "gcam" = "git commit --all --message";
    "amend" = "git commit --amend";
    "gco" = "git checkout";
    "gcop" = "git checkout --patch";
    "gb" = "git branch";
    "gp" = "git pull";
    "gpsh" = "git push";
    "gpshf" = "git push --force-with-lease";
    "gpshu" = "git push --set-upstream origin main";
    "gst" = "git stash push";
    "gstp" = "git stash pop";
  };
}
