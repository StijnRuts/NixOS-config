{ pkgs, ... }:
{
  programs.bat = {
    enable = true;
    extraPackages = [ pkgs.bat-extras.core ];
  };

  catppuccin.bat.enable = true;

  home.shellAliases = {
    "cat" = "bat --paging=never";
    "less" = "bat --paging=always";
    "man" = "batman";
  };

  programs.zsh.shellGlobalAliases = {
    "--help" = "--help 2>&1 | bat --language=help --style=plain";
  };
}
