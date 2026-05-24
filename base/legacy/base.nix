let
  recursive = import (
    builtins.fetchurl {
      url = "https://raw.githubusercontent.com/StijnRuts/nix-recursive-merge/4a3077519c121a9b67ec5e6141c488564e8a3041/recursive.nix";
      sha256 = "sha256:1pmp8vz2qsxnm4dbd34kahpgrdmfp1r2v03r77p0gw1k1764nppz";
    }
  );
in
# TODO convert this to the new format
recursive.mergeImports [
  ./secrets/base.nix
  ./system/base.nix
  ./KDE/base.nix
  ./niri/base.nix
  ./theme/base.nix
  ./apps/base.nix
  ./energy/base.nix
  ./server/base.nix
]
