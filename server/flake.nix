{
  outputs = _: {
    nixosModules = [
      ./atuin.nix
      ./syncthing.nix
      ./tarsnap.nix
    ];
  };
}
