let
  recursive = import (
    builtins.fetchurl {
      url = "https://raw.githubusercontent.com/StijnRuts/nix-recursive-merge/4a3077519c121a9b67ec5e6141c488564e8a3041/recursive.nix";
      sha256 = "sha256:1pmp8vz2qsxnm4dbd34kahpgrdmfp1r2v03r77p0gw1k1764nppz";
    }
  );
  fix =
    f:
    let
      x = f x;
    in
    x;
  base = rec {
    dir = ./base;
    subdirs = builtins.attrNames (builtins.readDir dir);
    paths = map (subdir: "${dir}/${subdir}/base.nix") subdirs;
    config = fix (recursive.mergeImports paths);
  };
in
{
  inherit (base.config) inputs outputs;
}
