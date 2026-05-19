{ pkgs, ... }:
{
  environment.systemPackages = [ pkgs.nixos-container ];
  boot.enableContainers = true;
}
