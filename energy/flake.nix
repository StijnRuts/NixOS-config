{
  outputs = _: {
    modules = {
      nixos = [
        ./laptop.nix
      ];
      home = [
        ./server.nix
      ];
    };
  };
}
