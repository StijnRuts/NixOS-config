{ lib, isServer, ... }:
(lib.optionalAttrs isServer {
  programs.plasma.powerdevil.AC.autoSuspend.action = "nothing";
})
