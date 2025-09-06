pkgs: {
  enable = true;
  nativeMessagingHosts = [ pkgs.kdePackages.plasma-browser-integration ];
  profiles.default = {
    # about:config
    settings = {
      "browser.shell.checkDefaultBrowser" = false;
      "browser.aboutConfig.showWarning" = false;
      "browser.urlbar.trimURLs" = false;
      "browser.urlbar.trimHttps" = false;
      "widget.use-xdg-desktop-portal.file-picker" = 1; # native file picker
      "browser.toolbars.bookmarks.visibility" = "never"; # no bookmark bar
      "browser.startup.page" = 3; # open previous windows and tabs on startup
      "devtools.selfxss.count" = 99; # allow pasting in console
      "browser.gesture.swipe.left" = "cmd_scrollLeft"; # disable scrolling trough history
      "browser.gesture.swipe.right" = "cmd_scrollRight"; # disable scrolling trough history
      "browser.translations.neverTranslateLanguages" = "nl";
    };
    search = {
      force = true;
      default = "ddg";
      engines = {
        "ddg" = {
          name = "DuckDuckGo";
          urls = [ { template = "https://duckduckgo.com/?q={searchTerms}"; } ];
          icon = "https://duckduckgo.com/favicon.ico";
          definedAliases = [ "@ddg" ];
        };
        "g" = {
          name = "Google";
          urls = [ { template = "https://www.google.com/search?q={searchTerms}"; } ];
          icon = "https://www.google.com/favicon.ico";
          definedAliases = [ "@g" ];
        };
        "w" = {
          name = "Wikipedia";
          urls = [ { template = "https://wikipedia.org/wiki/Special:Search?search={searchTerms}"; } ];
          icon = "https://wikipedia.org/static/favicon/wikipedia.ico";
          definedAliases = [ "@w" ];
        };
        "nw" = {
          name = "NixOS Wiki";
          urls = [ { template = "https://wiki.nixos.org/w/index.php?search={searchTerms}"; } ];
          icon = "https://wiki.nixos.org/favicon.ico";
          definedAliases = [ "@nw" ];
        };
        "nwu" = {
          name = "Unofficial NixOS Wiki";
          urls = [ { template = "https://nixos.wiki/index.php?search={searchTerms}"; } ];
          icon = "https://nixos.wiki/favicon.png";
          definedAliases = [ "@nwu" ];
        };
        "aw" = {
          name = "Arch Wiki";
          urls = [ { template = "https://wiki.archlinux.org/index.php?search={searchTerms}"; } ];
          icon = "https://wiki.archlinux.org/favicon.ico";
          definedAliases = [ "@aw" ];
        };
        "np" = {
          name = "Nix Packages";
          urls = [ { template = "https://search.nixos.org/packages?query={searchTerms}"; } ];
          icon = "https://search.nixos.org/favicon.png";
          definedAliases = [ "@np" ];
        };
        "no" = {
          name = "NixOS Options";
          urls = [ { template = "https://search.nixos.org/options?&query={searchTerms}"; } ];
          icon = "https://search.nixos.org/favicon.png";
          definedAliases = [ "@no" ];
        };
        "hm" = {
          name = "Home Manager Options";
          urls = [ { template = "https://home-manager-options.extranix.com/?query={searchTerms}"; } ];
          icon = "https://home-manager-options.extranix.com/images/favicon.png";
          definedAliases = [ "@hm" ];
        };
        "pm" = {
          name = "Plasma Manager Options";
          urls = [ { template = "https://nix-community.github.io/plasma-manager/options.xhtml"; } ];
          icon = "https://home-manager-options.extranix.com/images/favicon.png";
          definedAliases = [ "@pm" ];
        };
        "n" = {
          name = "Noogle";
          urls = [ { template = "https://noogle.dev/q?term={searchTerms}"; } ];
          icon = "https://noogle.dev/favicon.png";
          definedAliases = [ "n" ];
        };
        "mn" = {
          name = "MyNixOS";
          urls = [ { template = "https://mynixos.com/search?q={searchTerms}"; } ];
          icon = "https://mynixos.com/favicon-32x32.png";
          definedAliases = [ "mn" ];
        };
        "npv" = {
          name = "Nix package versions";
          urls = [
            { template = "https://lazamar.co.uk/nix-versions/?channel=nixpkgs-unstable&package={searchTerms}"; }
          ];
          icon = "https://search.nixos.org/favicon.png";
          definedAliases = [ "npv" ];
        };
        "nvf" = {
          name = "NVF Options";
          urls = [ { template = "https://notashelf.github.io/nvf/options.html"; } ];
          icon = "https://neovim.io/favicon.ico";
          definedAliases = [ "nvf" ];
        };
        "mdn" = {
          name = "MDN";
          urls = [ { template = "https://developer.mozilla.org/en-US/search?q={searchTerms}"; } ];
          icon = "https://developer.mozilla.org/favicon.ico";
          definedAliases = [ "@mdn" ];
        };
        "p" = {
          name = "Pursuit";
          urls = [ { template = "https://pursuit.purescript.org/search?q={searchTerms}"; } ];
          icon = "https://pursuit.purescript.org/static/res/favicon/favicon.ico";
          definedAliases = [ "@p" ];
        };
      };
    };
  };
  policies = {
    # https://mozilla.github.io/policy-templates/#extensionsettings
    ExtensionSettings =
      builtins.mapAttrs
        (pluginId: area: {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/${pluginId}/latest.xpi";
          installation_mode = "normal_installed";
          default_area = area;
        })
        {
          # Get pluginId from about:support
          "uBlock0@raymondhill.net" = "menupanel"; # uBlock Origin
          "jid1-MnnxcxisBPnSXQ@jetpack" = "menupanel"; # Privacy Badger
          "support@lastpass.com" = "navbar"; # LastPass
          "addon@darkreader.org" = "menupanel"; # Dark Reader
          "languagetool-webextension@languagetool.org" = "menupanel"; # LanguageTool
          "plasma-browser-integration@kde.org" = "menupanel"; # Plasma Integration
        };
    PasswordManagerEnabled = false;
    AutofillAddressEnabled = false;
    AutofillCreditCardEnabled = false;
    NoDefaultBookmarks = true;
  };
}
