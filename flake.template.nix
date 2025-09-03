let
  recursive = import (
    builtins.fetchurl {
      url = "https://raw.githubusercontent.com/StijnRuts/nix-recursive-merge/289afa0337338737c3d61da12eaea3cd2f30bf03/recursive.nix";
      sha256 = "sha256:1a6wlrj21hgwc2gbfcdggyxgvg68vm3i1gvgbxdzqs47phqk3il0";
    }
  );
in
recursive.mergeImports [
  ./hosts/flake.nix
  ./user/flake.nix
  ./secrets/flake.nix
  ./system/flake.nix
  ./KDE/flake.nix
  ./theme/flake.nix
  ./apps/flake.nix
  ./energy/flake.nix
]
