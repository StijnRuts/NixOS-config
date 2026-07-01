{
  outputs = _: {
    homeModules.git =
      {
        config,
        lib,
        user,
        ...
      }:
      {
        options.custom.git = {
          enable = lib.mkEnableOption "git";
          email = lib.mkOption {
            type = lib.types.str;
          };
        };

        config = lib.mkIf config.custom.git.enable {
          programs = {
            git = {
              enable = true;
              settings = {
                user = {
                  name = "${user.fullname}";
                  email = "${config.custom.git.email}";
                };
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

            delta = {
              enable = true;
              enableGitIntegration = true;
            };

            # TODO move
            lazygit = {
              enable = true;
              settings = {
                gui = {
                  tabWidth = 2;
                  nerdFontsVersion = 3;
                  showRandomTip = false;
                  showCommandLog = false;
                  skipDiscardChangeWarning = true;
                };
                git = {
                  notARepository = "quit";
                  disableForcePushing = true;
                  pagers = [ { pager = "delta --paging=never"; } ];
                };
              };
            };
          };

          # catppuccin.lazygit.enable = true; # TODO

          home.shellAliases = {
            "gs" = "git status";
            "ga" = "git add";
            "gaa" = "git add --all";
            "gap" = "git add --patch";
            "gd" = "git diff";
            "gdw" = "git diff --ignore-all-space";
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
            "gsubi" = "git sumodule init";
            "gsubu" = "git sumodule update";
          };

          custom.persist.directories = [ ".local/state/lazygit" ];
        };
      };
  };
}
