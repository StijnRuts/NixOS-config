{ pkgs, me, ... }:
{
  environment.systemPackages = [
    pkgs.beekeeper-studio
  ];

  nixpkgs.config.permittedInsecurePackages = [
    "beekeeper-studio-5.1.5"
  ];

  environment.persistence."/persist" = {
    users.${me.username} = {
      directories = [
        ".config/beekeeper-studio"
      ];
    };
  };
}
