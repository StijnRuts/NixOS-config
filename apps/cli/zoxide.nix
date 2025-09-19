{ pkgs, ... }:
{
  programs = {
    zoxide = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      enableNushellIntegration = true;
      options = [ "--no-cmd" ]; # Replace the `z` shortcut with a custom script
    };
    bash.initExtra = ''
      function z {
        local tmpfile=$(mktemp)
        zoxide_fallback "$@" | tee "$tmpfile"
        local dir=$(tail -n 1 "$tmpfile")
        rm "$tmpfile"
        [ -d "$dir" ] && cd "$dir"
      }
    '';
    zsh.initContent = ''
      function z {
        local tmpfile=$(mktemp)
        zoxide_fallback "$@" | tee "$tmpfile"
        local dir=$(tail -n 1 "$tmpfile")
        rm "$tmpfile"
        [ -d "$dir" ] && cd "$dir"
      }
    '';
    nushell.extraConfig = ''
      def z [...args] {
        let tmpfile = mktemp
        zoxide_fallback ...$args | tee { save $tmpfile }
        let dir = (open $tmpfile | last)
        rm $tmpfile
        if ($dir | path exists) { cd $dir }
      }
    '';
  };

  home.packages = [
    pkgs.fd
    pkgs.fzf
    (pkgs.writers.writeBashBin "zoxide_fallback" (builtins.readFile ./zoxide_fallback.sh))
  ];

  persist.home = {
    directories = [
      ".local/share/zoxide"
    ];
  };
}
