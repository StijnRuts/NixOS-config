{ me, ... }:
{
  programs.git = {
    enable = true;
    userEmail = "${me.email.git}";
    userName = "${me.name}";
    extraConfig = {
      core.editor = "nvim";
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      pull.rebase = true;
      rebase.autoStash = true;
    };
    delta.enable = true;
  };
  catppuccin.delta.enable = true;

  programs.lazygit = {
    enable = true;
    settings = {
      gui = {
        tabWidth = 2;
        nerdFontsVersion = 3;
        showRandomTip = false;
        showCommandLog = false;
      };
      git = {
        paging.pager = "delta --paging=never";
        disableForcePushing = true;
      };
    };
  };
  catppuccin.lazygit.enable = true;

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
    "gl" = "git log --oneline -n 10";
    "gst" = "git stash push";
    "gstp" = "git stash pop";
  };

  home.persistence."/persist/home/${me.username}" = {
    allowOther = false;
    directories = [
      ".local/state/lazygit"
    ];
  };
}
