{ pkgs, ... }:
{
  programs.nushell = {
    enable = true;
    settings = {
      show_banner = false;
    };
    plugins = with pkgs.nushellPlugins; [
      formats
      query
    ];
  };

  programs.nix-your-shell = {
    enable = true;
    enableNushellIntegration = true;
  };

  persist.home = {
    files = [
      ".config/nushell/history.txt"
    ];
  };
}
