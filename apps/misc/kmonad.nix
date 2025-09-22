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
          url = "https://raw.githubusercontent.com/StijnRuts/keyboard-config/9eb6b5ba71b3a037a03832d613c8df3542eb170c/KMonad/corne-alike.kbd";
          sha256 = "sha256:03bk02w8sdbb63lcnq5q5i19pw30r9crj0nnv7sq1rp51vglz2nx";
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
