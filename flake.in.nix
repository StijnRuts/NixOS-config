let
  recursive = import (
    builtins.fetchurl {
      url = "https://raw.githubusercontent.com/StijnRuts/nix-recursive-merge/9d50a86218c6a8cf6880b490e5a76bce32af0fb1/recursive.nix";
      sha256 = "sha256:1lnwfn9h5mwn3vdsa7as0c86929p4w45bnkcw1lszbnh3y5im9q1";
    }
  );
in
recursive.mergeImports [
  ./modules/_disko
  ./modules/_X201
  ./modules/_en+nl_BE.nix
  ./modules/_networking.nix
  ./modules/_nix
  ./modules/__stijn
]
