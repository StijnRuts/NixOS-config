let
  pkgs = import (builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/nixos-26.05.tar.gz";
    sha256 = "sha256:1syqpgmk84bqjwf6l3b34b2j1h70760k1rb5715q85chvlzxyr0f";
  }) { system = "x86_64-linux"; };
  modules = pkgs.lib.modules.evalModules {
    modules = [
      # TODO autoload
      #./modules/browsers
      #./modules/disko
      ./modules/flake
      #./modules/homemanager
#     ./modules/host-X201
#      ./modules/hosts
      ./modules/locale
      ./modules/networking
#      ./modules/nix
#      ./modules/user-stijn
#      ./modules/users
    ];
  };
in
{
  inherit (modules.config) inputs outputs;
}
