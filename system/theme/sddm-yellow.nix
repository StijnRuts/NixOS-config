{ pkgs }:
pkgs.stdenv.mkDerivation {
  name = "sddm-yellow";
  version = "1.0";
  src = ./sddm-yellow.tar.gz;

  installPhase = ''
    mkdir -p $out/share/sddm/themes
    tar xvfz $src -C $out/share/sddm/themes
  '';
}
