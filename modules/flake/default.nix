{ lib, config, ... }:
{
  options =
    let
      coercedFunctionTo = type: lib.types.coercedTo type (x: _: x) (lib.types.functionTo type);
    in
    {
      inputs = lib.mkOption {
        type = lib.types.attrs;
        default = { };
      };
      outputs = lib.mkOption {
        # type = coercedFunctionTo (lib.types.attrTag config.flakeOutputs);
        type = lib.types.functionTo (
          lib.types.submodule {
            options = config.flakeOutputs;
          }
        );
        default = _: { };
      };
      flakeOutputs = lib.mkOption {
        type = lib.types.attrsOf lib.types.optionDeclaration;
        default = { };
      };
    };
}
