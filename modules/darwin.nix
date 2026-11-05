{
  self,
  inputs,
  pkgs,
  config,
  ...
}:
{
  imports = [
    inputs.home-manager.darwinModules.home-manager
  ];

  assertions = [ (self.lib.modules.assertIsDarwin pkgs) ];

  system = {
    inherit (config.swamp.users) primaryUser;

    # TODO: "Darwin Wrapper", see docs/darwin.md
    defaults = {
      # "Are you sure you want to open this app?"
      LaunchServices.LSQuarantine = false;

      NSGlobalDomain = {
        "com.apple.sound.beep.volume" = null;

        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticDashSubstitutionEnabled = false;
        NSAutomaticInlinePredictionEnabled = false;
        NSAutomaticPeriodSubstitutionEnabled = false;
        NSAutomaticQuoteSubstitutionEnabled = false;
        NSAutomaticSpellingCorrectionEnabled = false;

        NSDocumentSaveNewDocumentsToCloud = false;

        NSNavPanelExpandedStateForSaveMode = true; # Just the two of us
        NSNavPanelExpandedStateForSaveMode2 = true; # We can make it if we try
      };

      controlcenter.AirDrop = false;

      dock."show-recents" = false;

      finder = {
        AppleShowAllFiles = true;
        AppleShowAllExtensions = true;
        FXEnableExtensionChangeWarning = false;
      };

      loginwindow = {
        DisableConsoleAccess = true;
        GuestEnabled = false;
        HideUserAvatarAndName = true;
      };

      CustomUserPreferences = {
        NSGlobalDomain = {
          NSGlassBuddyTintAmount = 1;
          NSGlassEverEditedInBuddy = 1;
          NSGlassTintAmount = 1;

          NSUserDictionaryReplacementItems = [ ]; # "On my way!"
        };

        # .DS_Store should not infect anything non-local to this machine
        "com.apple.desktopservices" = {
          DSDontWriteNetworkStores = true;
          DSDontWriteUSBStores = true;
        };

        "com.apple.AdLib".allowApplePersonalizedAdvertising = false;

        "com.apple.spotlight".EnabledPreferenceRules = [ "Custom.relatedContents" ]; # This actually turns off related content lol
      };
    };
  };

  # I was just about getting good at typing my password as well
  security.pam.services.sudo_local.touchIdAuth = true;

  networking.applicationFirewall = {
    enable = true;
    blockAllIncoming = false;
    allowSigned = false; # Built-in apps
    allowSignedApp = false;
  };
}
