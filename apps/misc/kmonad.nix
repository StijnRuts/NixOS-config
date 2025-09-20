{
  services.kmonad =
    let
      defcfg = {
        enable = true;
        fallthrough = true;
        allowCommands = false;
      };
      config = builtins.readFile (
        builtins.fetchurl {
          url = "https://raw.githubusercontent.com/StijnRuts/keyboard-config/00bf69d040066da08027498c12321d11b10dcdfd/KMonad/corne-alike.kbd";
          sha256 = "sha256:1p36dmxgapvjvf3xx0k1i6mb02x2xbzwygb5l24i4lax351piy4g";
        }
      );
    in
    {
      enable = true;
      keyboards = {
        "thinkpad-internal" = {
          device = "/dev/input/by-path/platform-i8042-serio-0-event-kbd";
          inherit defcfg;
          inherit config;
        };
        "dell-azerty" = {
          device = "/dev/input/by-id/usb-Dell_Dell_USB_Entry_Keyboard-event-kbd";
          inherit defcfg;
          inherit config;
        };
      };
    };
}
