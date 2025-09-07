{
  outputs = _: {
    nixosModules = [
      ./atuin.nix
      ./nextcloud.nix
    ];
  };
}
