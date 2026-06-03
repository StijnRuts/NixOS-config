let
  pkgs = import (builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/nixos-26.05.tar.gz";
    sha256 = "sha256:0ldd02kkfzndk0x98zsg992gqz84ip18hvrq01wws6p96ki176rb";
  }) { system = "x86_64-linux"; };
  lib = pkgs.lib;
  modules = lib.modules.evalModules({
    modules = [./module.nix];
  });
in {
  inputs = modules.config.inputs;
  outputs = inputs: {
    nixosConfigurations = {
      X201 = inputs.nixpkgs.lib.nixosSystem (modules.config.nixosConfigurations.X201 inputs);
    };
  };
}
