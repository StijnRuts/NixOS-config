{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    gnumake
    nixfmt-rfc-style
  ];
}
