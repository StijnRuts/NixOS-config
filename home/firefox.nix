{
  config,
  pkgs,
  me,
  ...
}:
{
  programs.firefox = {
    enable = true;
    nativeMessagingHosts = [ pkgs.kdePackages.plasma-browser-integration ];
    profiles.default = {
      settings = {
        # about:config
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
            urls = [
              { template = "https://nix-community.github.io/plasma-manager/options.xhtml?query={searchTerms}"; }
            ];
            icon = "https://home-manager-options.extranix.com/images/favicon.png";
            definedAliases = [ "@pm" ];
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
      # Get ID from about:support
      ExtensionSettings = {
        # uBlock Origin
        "uBlock0@raymondhill.net" = {
          installation_mode = "normal_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/uBlock0@raymondhill.net/latest.xpi";
          default_area = "menupanel";
        };
        # Privacy Badger
        "jid1-MnnxcxisBPnSXQ@jetpack" = {
          installation_mode = "normal_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/jid1-MnnxcxisBPnSXQ@jetpack/latest.xpi";
          default_area = "menupanel";
        };
        # LastPass
        "support@lastpass.com" = {
          installation_mode = "normal_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/support@lastpass.com/latest.xpi";
          default_area = "navbar";
        };
        # Dark Reader
        "addon@darkreader.org" = {
          installation_mode = "normal_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/addon@darkreader.org/latest.xpi";
          default_area = "menupanel";
        };
        # LanguageTool
        "languagetool-webextension@languagetool.org" = {
          installation_mode = "normal_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/languagetool-webextension@languagetool.org/latest.xpi";
          default_area = "menupanel";
        };
        # Plasma Integration
        "plasma-browser-integration@kde.org" = {
          installation_mode = "normal_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/plasma-browser-integration@kde.org/latest.xpi";
          default_area = "menupanel";
        };
      };
      PasswordManagerEnabled = false;
      AutofillAddressEnabled = false;
      AutofillCreditCardEnabled = false;
      FirefoxHome.SponsoredTopSites = false;
      FirefoxSuggest.SponsoredSuggestions = false;
      NoDefaultBookmarks = true;
    };
  };

  # Also install Chromium
  programs.chromium.enable = true;

  # Set Firefox as the default browser
  programs.plasma.configFile = {
    "kdeglobals"."General"."BrowserApplication" = "firefox.desktop";
  };
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = [ "firefox.desktop" ];
      "x-scheme-handler/http" = [ "firefox.desktop" ];
      "x-scheme-handler/https" = [ "firefox.desktop" ];
      "x-scheme-handler/about" = [ "firefox.desktop" ];
      "x-scheme-handler/unknown" = [ "firefox.desktop" ];
    };
  };
  home.sessionVariables.DEFAULT_BROWSER = "${pkgs.firefox}/bin/firefox";

  home.persistence."/persist/home/${me.username}" = {
    allowOther = false;
    directories = [
      ".mozilla"
      ".cache/mozilla"
      ".config/chromium"
      ".cache/chromium"
    ];
  };
}
