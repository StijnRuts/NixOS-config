base: {
  homeModules = _: [];
  outputs = inputs: {
    # TODO refactor
    homeModules = base.homeModules inputs;
  };
}
