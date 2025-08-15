{
  config,
  pkgs,
  lib,
  ...
}:
{ }

# TODO
# (lib.optionalAttrs (config.networking.hostName == "P520") {
#   home.activation.P520RefreshRate = lib.hm.dag.entryAfter [ ] ''
#     ${pkgs.kdePackages.libkscreen}/bin/kscreen-doctor output.DP-1.mode.2560x1440@144
#   '';
# })
