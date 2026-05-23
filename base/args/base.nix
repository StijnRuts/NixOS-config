base: {
  args = _: _: {};
  outputs = inputs: {
    # TODO refactor
    args = base.args "x86_64_linux" inputs;
  };
}
