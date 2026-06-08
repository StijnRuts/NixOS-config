{ pkgs, ... }:
{
  environment.systemPackages = [ pkgs.nixos-container ];
  boot.enableContainers = true;

  networking.nat = {
    enable = true;
    internalInterfaces = [
      "ve-+"
      "ve-*"
    ];
    externalInterface = "wlp3s0";
  };
}
