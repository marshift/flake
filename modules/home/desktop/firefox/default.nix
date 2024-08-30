{ config, lib, pkgs, ... }:

let
  lockFalse = {
    Value = false;
    Status = "locked";
  };
  lockTrue = {
    Value = true;
    Status = "locked";
  };
in
lib.habitat.mkModule {
  inherit config;
  path = [ "home" "desktop" "firefox" ];
  output = {
    programs.firefox = {
      enable = true;
      package = pkgs.firefox-beta;

      # about:policies#documentation
      policies = {
        EnableTrackingProtection = {
          Value= true;
          Locked = true;
          Cryptomining = true;
          Fingerprinting = true;
        };
        DisableTelemetry = true;
        DisableFirefoxStudies = true;
        DisablePocket = true;
        DisableAccounts = true;
        DisableFirefoxAccounts = true;
        DisableFirefoxScreenshots = true;
        OverrideFirstRunPage = "";
        OverridePostUpdatePage = "";
        DontCheckDefaultBrowser = true;
        AutofillAddressEnabled = false;
        AutofillCreditCardEnabled = false;
        OfferToSaveLogins = false;
        PasswordManagerEnabled = false;
        DisplayBookmarksToolbar = "never";
        DisplayMenuBar = "never";
        SearchBar = "unified";

        ExtensionSettings = {
          "*".installation_mode = "blocked"; # Block new extensions

          "uBlock0@raymondhill.net" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
            installation_mode = "force_installed";
          };
          "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
            installation_mode = "force_installed";
          };
        };
  
        # about:config
        # TODO: More of these can be moved to use policies but... blegh.
        Preferences = { 
          "browser.tabs.inTitlebar" = 0;
          "browser.contentblocking.category" = { Value = "strict"; Status = "locked"; };
          "extensions.pocket.enabled" = lockFalse;
          "extensions.screenshots.disabled" = lockTrue;
          "browser.topsites.contile.enabled" = lockFalse;
          "browser.formfill.enable" = lockFalse;
          "browser.search.suggest.enabled" = lockFalse;
          "browser.search.suggest.enabled.private" = lockFalse;
          "browser.urlbar.suggest.searches" = lockFalse;
          "browser.urlbar.showSearchSuggestionsFirst" = lockFalse;
          "browser.newtabpage.activity-stream.feeds.section.topstories" = lockFalse;
          "browser.newtabpage.activity-stream.feeds.snippets" = lockFalse;
          "browser.newtabpage.activity-stream.section.highlights.includePocket" = lockFalse;
          "browser.newtabpage.activity-stream.section.highlights.includeBookmarks" = lockFalse;
          "browser.newtabpage.activity-stream.section.highlights.includeDownloads" = lockFalse;
          "browser.newtabpage.activity-stream.section.highlights.includeVisited" = lockFalse;
          "browser.newtabpage.activity-stream.showSponsored" = lockFalse;
          "browser.newtabpage.activity-stream.system.showSponsored" = lockFalse;
          "browser.newtabpage.activity-stream.showSponsoredTopSites" = lockFalse;
        };
      };
    };
  };
}
