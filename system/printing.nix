{ pkgs, ... }:
{
  services.printing.enable = true;
  services.printing.drivers = [
    pkgs.gutenprint
    pkgs.gutenprintBin
    pkgs.brlaser
  ];

  environment.persistence."/persist" = {
    directories = [
      "/etc/cups"
    ];
  };
}
