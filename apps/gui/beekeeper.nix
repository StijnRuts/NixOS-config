{ pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.beekeeper-studio
  ];

  nixpkgs.config.permittedInsecurePackages = [
    "beekeeper-studio-5.1.5"
  ];

  persist.home = {
    directories = [
      ".config/beekeeper-studio"
    ];
  };
}
