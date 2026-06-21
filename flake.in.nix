let
  recursive = import (
    builtins.fetchurl {
      url = "https://raw.githubusercontent.com/StijnRuts/nix-recursive-merge/9d50a86218c6a8cf6880b490e5a76bce32af0fb1/recursive.nix";
      sha256 = "sha256:1lnwfn9h5mwn3vdsa7as0c86929p4w45bnkcw1lszbnh3y5im9q1";
    }
  );
  pipe = builtins.foldl' (x: f: f x);
  skipUnderscores = builtins.filter (p: "_" != builtins.substring 0 1 p);
  importModules = builtins.map (p: import (./modules + "/${p}"));
  modules = pipe ./modules [
    builtins.readDir
    builtins.attrNames
    skipUnderscores
    importModules
  ];
in
recursive.mergeList modules
