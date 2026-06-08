{ lib, ... }:
let
  outputsType = lib.types.mkOptionType {
    name = "outputs";
#    merge =
#      locs: defs: args:
#      (lib.options.mergeDefaultOption locs (
#        map (d: d // { value = if lib.isFunction d.value then d.value args else d.value; }) (lib.debug.traceVal defs)
#
#      ));
      merge = locs: defs: _: lib.options.mergeDefaultOption locs defs;
  };
in
{
  options = {
    inputs = lib.mkOption {
      type = lib.types.anything; # TODO
      default = { };
    };
    outputs = lib.mkOption {
      type = outputsType;
      default = { };
    };
  };
}
