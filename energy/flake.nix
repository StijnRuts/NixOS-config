{
  outputs = _: {
    nixosModules = [
      ./laptop.nix
    ];
    homeModules = [
      ./server.nix
    ];
  };
}
