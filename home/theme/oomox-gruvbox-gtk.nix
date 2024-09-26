{ pkgs }:
pkgs.stdenv.mkDerivation {
  name = "oomox-gruvbox-gtk";
  version = "1.0";
  src = ./oomox-gruvbox-gtk.tar.gz;

  installPhase = ''
    mkdir -p $out/share/themes
    tar xvfz $src -C $out/share/themes
  '';
}
