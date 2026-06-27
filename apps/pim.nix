{ pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.ttdl
    pkgs.zk
    pkgs.pace
    pkgs.harsh
  ];
}
