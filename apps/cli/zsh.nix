{ pkgs, ... }:
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
  };

  programs.nix-your-shell = {
    enable = true;
    enableZshIntegration = true;
  };

  persist.home = {
    files = [
      ".zsh_history"
    ];
  };
}
