{ pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.beekeeper-studio
  ];

  nixpkgs.config.permittedInsecurePackages = [
    "beekeeper-studio-5.3.4"
  ];

  persist.home = {
    directories = [
      ".config/beekeeper-studio"
    ];
  };
}
