{
  outputs = _: {
    nixosModules = [
      ./atuin.nix
      ./tarsnap.nix
    ];
  };
}
