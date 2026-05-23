{ pkgs, lib, ... }:
{
  environment.systemPackages = [
    pkgs.httpie
    pkgs.httpie-desktop
    pkgs.jq
  ];

  allowUnfree = [
    "httpie-desktop"
  ];
}
