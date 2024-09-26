{ pkgs }:
pkgs.stdenv.mkDerivation {
  name = "oomox-gruvbox-icons";
  version = "1.0";
  src = ./oomox-gruvbox-icons.tar.gz;

  installPhase = ''
    mkdir -p $out/share/icons
    tar xvfz $src -C $out/share/icons
  '';
}
