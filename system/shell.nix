{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    gnumake
    git
    nixfmt-rfc-style
  ];
}
