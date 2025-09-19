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
          url = "https://raw.githubusercontent.com/StijnRuts/keyboard-config/b5ff8f85f5469e71eee62765c3b71b5e1b762aa5/KMonad/corne-alike.kbd";
          sha256 = "sha256:1hf33xa7vd01r8cwllamlqb1l3mwdkw0vvjyqiyl2rhg5ab707wz";
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
