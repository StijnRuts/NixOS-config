{ pkgs, me, ... }:
{
  programs.git = {
    enable = true;
    userEmail = "${me.email.git}";
    userName = "${me.name}";
    delta.enable = true;
    extraConfig = {
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      pull.rebase = true;
      rebase.autoStash = true;
      delta = {
        syntax-theme = "none";
        hunk-header-style = "normal";
        minus-style = "red";
        minus-non-emph-style = "red";
        minus-emph-style = "reverse red";
        plus-style = "green";
        plus-non-emph-style = "green";
        plus-emph-style = "reverse green";
      };
    };
  };

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
        disableForcePushing = true;
        paging.pager = "delta --paging=never";
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
    "gl" = "git log --oneline -n 10";
    "gst" = "git stash push";
    "gstp" = "git stash pop";
  };

  home.packages = [
    (pkgs.writers.writeBashBin "wipe" ''
      git restore --source=HEAD --staged --worktree -- .
      git clean -fd
    '')
  ];

  persist.home = {
    directories = [
      ".local/state/lazygit"
    ];
  };
}
