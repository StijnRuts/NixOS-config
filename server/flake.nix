{
  outputs = _: {
    nixosModules = [
      ./atuin.nix
      ./nextcloud.nix
      ./tarsnap.nix
    ];
  };
}
