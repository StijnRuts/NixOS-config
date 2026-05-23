base: {
  nixosModules = _: [];
  outputs = inputs: {
    # TODO refactor
    nixosModules = base.nixosModules inputs;
  };
}
