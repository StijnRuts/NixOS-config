{ pkgs, me, ... }:
{
  programs.zsh = {
    enable = true;
    autocd = true;
    autosuggestion.enable = true;
    defaultKeymap = "emacs";
    enableCompletion = true;
    completionInit = "autoload -Uz compinit && compinit && zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'"; # Case insensitive autocomplete
    history.ignoreDups = true;
    syntaxHighlighting.enable = true;
    initContent = ''
      unsetopt BEEP # no beeping
      bindkey "^[[3~" delete-char # fix delete key
      bindkey "^[OH" beginning-of-line # fix home key
      bindkey "^[OF" end-of-line # fix end key
      bindkey "^[OA" up-line-or-history # fix up key
      bindkey "^[OB" down-line-or-history # fix down key
      bindkey "^[OC" forward-char # fix right key
      bindkey "^[OD" backward-char # fix left key
    '';
    plugins = [
      {
        name = "zsh-nix-shell";
        file = "nix-shell.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "chisui";
          repo = "zsh-nix-shell";
          rev = "v0.8.0";
          sha256 = "1lzrn0n4fxfcgg65v0qhnj7wnybybqzs4adz7xsrkgmcsr0ii8b7";
        };
      }
    ];
  };

  home.persistence."/persist/home/${me.username}" = {
    allowOther = false;
    files = [
      ".zsh_history"
    ];
  };
}
