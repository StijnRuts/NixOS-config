{
  config,
  osConfig,
  pkgs,
  lib,
  ...
}:
{
  options.apps.syncthing.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable Syncthing";
  };

  config = lib.mkIf config.apps.syncthing.enable {
    services.syncthing = {
      enable = true;
      cert = config.age.secrets.${osConfig.networking.hostName + "_cert"}.path;
      key = config.age.secrets.${osConfig.networking.hostName + "_key"}.path;
      overrideFolders = true;
      overrideDevices = true;
      settings = {
        folders =
          let
            folderOptions = {
              devices = [
                "P520"
                "T420"
                "X201"
              ];
            };
          in
          {
            "~/Documents" = folderOptions;
            "~/Downloads" = folderOptions;
            "~/Music" = folderOptions;
            "~/NixOS" = folderOptions;
            "~/Pictures" = folderOptions;
            "~/Projects" = folderOptions;
            "~/Public" = folderOptions;
            "~/Templates" = folderOptions;
            "~/Videos" = folderOptions;
          };
        devices = {
          P520 = {
            addresses = [ "tcp://P520.local:22000" ];
            id = "Q3EHP3V-U7I2HUY-YIRHE7C-DLH7TR6-FN66TGE-AUHEKZQ-E72QIEH-I3WTHAS";
          };
          T420 = {
            addresses = [ "tcp://T420.local:22000" ];
            id = "VQ4BE2H-62EOMGB-U4BT7A6-XMFVBX3-YBSY3KP-6ZUTALI-BE3B2E3-KBBOKAE";
          };
          X201 = {
            addresses = [ "tcp://X201.local:22000" ];
            id = "BHILPE5-EPQUJJY-ESHAXTV-TUUNJEW-XEXNVQC-LDTUOXR-CWVEQ64-IZBWZAX";
          };
        };
      };

      tray = {
        enable = true;
        package = pkgs.syncthingtray; # Full package
      };
    };

    age.secrets = {
      P520_cert.file = ../../secrets/syncthing/P520_cert.age;
      P520_key.file = ../../secrets/syncthing/P520_key.age;
      T420_cert.file = ../../secrets/syncthing/T420_cert.age;
      T420_key.file = ../../secrets/syncthing/T420_key.age;
      X201_cert.file = ../../secrets/syncthing/X201_cert.age;
      X201_key.file = ../../secrets/syncthing/X201_key.age;
    };

    persist.home = {
      directories = [
        ".local/state/syncthing"
      ];
    };
  };
}
