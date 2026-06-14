{ self, config, lib, ... }:
{
  outputs.nixosModules.browsers = {
    options = {
      browsers.enable = lib.mkEnableOption {};
    };

    imports = [
      self.nixosModules.firefox
      self.nixosModules.chromium
      self.nixosModules.qutebrowser
      self.nixosModules.w3m
    ];

    config = {
      firefox.enable = lib.mkDefault config.browsers.enable;
      chromium.enable = lib.mkDefault config.browsers.enable;
      qutebrowser.enable = lib.mkDefault config.browsers.enable;
      w3m.enable = lib.mkDefault config.browsers.enable;
    };
  };
}
