# TODO: Move program-specific firewall rules into their modules?
{
  lib,
  config,
  ...
}:
let
  inherit (lib.trivial) mergeAttrs;
  inherit (lib.lists) map concatLists imap1;
  inherit (config.swamp.users) users;

  cfg = config.swamp.security.little-snitch;
  appStoreAction = if cfg.appStore.enable then "allow" else "deny";

  mkHomeManagerAppRuleset =
    executable: rule:
    map (
      name:
      mergeAttrs rule {
        process = "${config.users.users.${name}.home}/Applications/Home Manager Apps${executable}";
      }
    ) users;

  # Terrible hack to define rules for all users - on macOS, UIDs start at 500, so iterate our users and calculate their UID based on that.
  # This makes several assumptions, but primarily that the users on the Mac were created in the same order they are defined in our config.
  # "anyway this solution sucks huge dick and balls but it works"
  mkGlobalRuleset =
    rule:
    concatLists [
      [ (mergeAttrs rule { owner = "system"; }) ]
      (imap1 (idx: _: mergeAttrs rule { uid = 500 + idx; }) config.swamp.users.users)
    ];
in
{
  imports = [
    ./_module.nix
  ];

  config = lib.modules.mkIf cfg.enable {
    homebrew.casks = [ "little-snitch@nightly" ];

    services.little-snitch = {
      enable = true;
      config = {
        /*nixfmt:disable*/
        rules = concatLists [
          # General
          [{ action = "deny"; process = "any"; remote-domains = [ "sentry.io" ]; priority = "high"; }]

          # Nix
          # Allow anything to connect to Nix "CDNs" for switching
          [{ action = "allow"; process = "any"; remote-hosts = [ "cache.nixos.org" "channels.nixos.org" ]; ports = "443"; protocol = "tcp"; }]

          # Apps
          [
            { action = "allow"; process = "identifier.W5364U7YZB/io.tailscale.ipn.macsys.network-extension"; remote = "any"; direction = "both"; }

            { action = "allow"; process = "identifier.W5364U7YZB/io.tailscale.ipn.macsys"; remote = "any"; }
            { action = "allow"; process = "identifier.24VZTF6M5V/com.mitchellh.ghostty"; remote = "any"; }
            { action = "allow"; process = "identifier.2BUA8C4S2C/com.1password.1password"; remote = "any"; }
            { action = "allow"; process = "identifier.S4Q33XPHB4/net.imput.helium"; remote = "any"; }
            { action = "allow"; process = "identifier.53Q6R32WPB/com.hnc.DiscordCanary"; remote = "any"; }
            { action = "allow"; process = "identifier.53Q6R32WPB/com.hnc.DiscordCanary.helper"; remote = "any"; }
            { action = "allow"; process = "identifier.53Q6R32WPB/com.hnc.DiscordCanary.helper.Renderer"; remote = "any"; }
            { action = "allow"; process = "identifier.UBF8T346G9/com.microsoft.VSCode"; remote = "any"; }
            { action = "allow"; process = "identifier.TQ3LTB39SU/app.liten.Gram"; remote = "any"; }
            { action = "allow"; process = "identifier.2ZEFAR8TH3/com.jetbrains.intellij"; remote = "any"; }
            { action = "allow"; process = "identifier.43AQ936H96/org.mozilla.thunderbird"; remote = "any"; }

            { action = "allow"; process = "identifier.MZM5U2NVNH/org.prismlauncher.PrismLauncher"; remote = "any"; }

            # This will probably break link previews but those are insecure so should be disabled anyway
            { action = "allow"; process = "identifier.U68MSDN6DR/org.whispersystems.signal-desktop"; remote-domains = [ "signal.org" ]; }

            # Geolocation database
            { action = "allow"; process = "identifier.MLZF7K7B5R/at.obdev.littlesnitch.networking"; remote = "any"; }

            # TODO: Firewall rule to allow modules/development/slumber to access all hosts

            # Update checks for Homebrew apps
            { action = "deny"; process = "identifier.MLZF7K7B5R/at.obdev.littlesnitch.softwareupdate"; remote = "any"; }
            { action = "deny"; process = "identifier.5F967GYF84/com.MrKai77.Loop"; remote = "any"; }
          ]

          # Apple
          [
             # Just in case...
            { action = "ask"; process = "appGroup.macOS"; remote = "any"; }

            # DNS :thumbsup:
            { action = "allow"; process = "identifier.APPLE/com.apple.mDNSResponder"; direction = "both"; remote = "any"; owner = "system"; }

            # Wallpapers
            { action = "allow"; process = "identifier.APPLE/com.apple.wallpaper.extension.aerials"; remote = "any"; }

            # I want betas sometimes
            { action = "allow"; process = "identifier.APPLE/com.apple.betaenrollmentagent"; remote = "any"; }

            # Required to manage Apple ID settings
            { action = "allow"; process = "identifier.APPLE/com.apple.icloudwebd"; remote = "any"; }

            # Apple ID
            { action = "allow"; process = "identifier.APPLE/com.apple.mobileactivationd"; remote = "any"; }
            { action = "allow"; process = "identifier.APPLE/com.apple.identityservicesd"; remote = "any"; }
            { action = "allow"; process = "identifier.APPLE/com.apple.iCloudNotificationAgent"; remote = "any"; }
            { action = "allow"; process = "identifier.APPLE/com.apple.amsaccountsd"; remote = "any"; }
            { action = "allow"; process = "identifier.APPLE/com.apple.systempreferences.AppleIDSettings"; remote = "any"; }
            { action = "allow"; process = "identifier.APPLE/com.apple.appleaccountd"; remote-hosts = "setup.icloud.com"; }
            { action = "allow"; process = "identifier.APPLE/com.apple.dataaccess.dataaccessd"; remote = "any"; }
            { action = "allow"; process = "identifier.APPLE/com.apple.iCloudHelper"; remote = "any"; }
            { action = "allow"; process = "identifier.APPLE/com.apple.akd"; remote = "any"; }

            { action = "allow"; process = "identifier.APPLE/com.apple.weatherd"; remote = "any"; }
            { action = "allow"; process = "identifier.APPLE/com.apple.wifivelocityd"; remote = "any"; }
            { action = "allow"; process = "identifier.APPLE/com.apple.softwareupdated"; remote = "any"; }
            { action = "allow"; process = "identifier.APPLE/com.apple.mobile.softwareupdated"; remote = "any"; }
            { action = "allow"; process = "identifier.APPLE/com.apple.captiveagent"; remote = "any"; }
            { action = "allow"; process = "identifier.APPLE/com.apple.swcd"; remote = "any"; }
            { action = "allow"; process = "identifier.APPLE/com.apple.FeatureAccessAgent"; remote = "any"; }
            { action = "allow"; process = "identifier.APPLE/com.apple.ValidUpdater"; remote = "any"; }
            { action = "allow"; process = "identifier.APPLE/com.apple.apsd";remote = "any"; }
            { action = "allow"; process = "identifier.APPLE/com.apple.mobileassetd"; remote-domains = "apple.com"; }
            { action = "allow"; process = "identifier.APPLE/com.apple.netbiosd"; remote = "any"; }
            { action = "allow"; process = "identifier.APPLE/com.apple.nsurlsessiond"; remote = "any"; }
            { action = "allow"; process = "identifier.APPLE/com.apple.timed"; remote-hosts = "time.apple.com"; }

            # Samba
            { action = "allow"; process = "/System/Library/Kernels/kernel"; remote = "any"; }
            { action = "allow"; process = "identifier.APPLE/com.apple.NetAuthSysAgent"; remote = "any"; }
            { action = "allow"; process = "identifier.APPLE/com.apple.finder"; remote = "any"; }

            # App Store
            { action = appStoreAction; process = "identifier.APPLE/com.apple.appstored"; remote = "any"; }
            { action = appStoreAction; process = "identifier.APPLE/com.apple.appstoreagent"; remote = "any"; }
            { action = appStoreAction; process = "identifier.APPLE/com.apple.AssetCacheLocatorService"; remote = "any"; }
            { action = appStoreAction; process = "identifier.APPLE/com.apple.jetpackassetd"; remote = "any"; }
            { action = appStoreAction; process = "identifier.APPLE/com.apple.AppStore"; remote = "any"; }
            { action = appStoreAction; process = "identifier.APPLE/com.apple.accountsd"; remote = "any"; }

            { action = "deny"; process = "identifier.APPLE/com.apple.mobile.NRDUpdated"; remote = "any"; }
            { action = "deny"; process = "identifier.APPLE/com.apple.knowledge-agent"; remote = "any"; }
            { action = "deny"; process = "identifier.APPLE/com.apple.commerce"; remote = "any"; }
            { action = "deny"; process = "identifier.APPLE/com.apple.news.tag"; remote = "any"; }
            { action = "deny"; process = "identifier.APPLE/com.apple.news.widget"; remote = "any"; }
            { action = "deny"; process = "identifier.APPLE/com.apple.news.widgetintents"; remote = "any"; }
            { action = "deny"; process = "identifier.APPLE/com.apple.stocks.widget"; remote = "any"; }
            { action = "deny"; process = "identifier.APPLE/com.apple.weather.widget"; remote = "any"; }
            { action = "deny"; process = "identifier.APPLE/com.apple.transparencyd"; remote = "any"; }
            { action = "deny"; process = "identifier.APPLE/com.apple.AirPlayXPCHelper"; remote = "any"; }
            { action = "deny"; process = "identifier.APPLE/com.apple.privatecloudcomputed"; remote = "any"; }
            { action = "deny"; process = "identifier.APPLE/com.apple.Game-Center-Settings.extension"; remote = "any"; }
            { action = "deny"; process = "identifier.APPLE/com.apple.gamed"; remote = "any"; }
            { action = "deny"; process = "identifier.APPLE/com.apple.homed"; remote = "any"; }
            { action = "deny"; process = "identifier.APPLE/com.apple.translationd"; remote = "any"; }
            { action = "deny"; process = "identifier.APPLE/com.apple.passd"; remote = "any"; }
            { action = "deny"; process = "identifier.APPLE/com.apple.sharingd"; remote = "any"; }
            { action = "deny"; process = "identifier.APPLE/com.apple.cloudphotod"; remote = "any"; }
            { action = "deny"; process = "identifier.APPLE/com.apple.shazameventsd"; remote = "any"; }
            { action = "deny"; process = "identifier.APPLE/com.apple.AMPArtworkAgent"; remote = "any"; }
            { action = "deny"; process = "identifier.APPLE/com.apple.AMPLibraryAgent"; remote = "any"; }
            { action = "deny"; process = "identifier.APPLE/com.apple.CallHistorySyncHelper"; remote = "any"; }
            { action = "deny"; process = "identifier.APPLE/com.apple.studentd"; remote = "any"; }
            { action = "deny"; process = "identifier.APPLE/com.apple.swtransparencyd"; remote = "any"; }
            { action = "deny"; process = "identifier.APPLE/com.apple.itunescloudd"; remote = "any"; }
            { action = "deny"; process = "identifier.APPLE/com.apple.ap.adprivacyd"; remote = "any"; }
            { action = "deny"; process = "identifier.APPLE/com.apple.askpermissiond"; remote = "any"; }
            { action = "deny"; process = "identifier.APPLE/com.apple.managedappdistributionagent"; remote = "any"; }
            { action = "deny"; process = "identifier.APPLE/com.apple.managedappdistributiond"; remote = "any"; }
            { action = "deny"; process = "identifier.APPLE/com.apple.Safari.PasswordBreachAgent"; remote = "any"; }
            { action = "deny"; process = "identifier.APPLE/com.apple.campo"; remote = "any"; } # Siri
            { action = "deny"; process = "identifier.APPLE/com.apple.unilog.SafariSearchUploadWorker"; remote = "any"; }
            { action = "deny"; process = "identifier.APPLE/com.apple.ctcategories.service"; remote = "any"; }
            { action = "deny"; process = "identifier.APPLE/com.apple.sbd"; remote = "any"; }
            { action = "deny"; process = "identifier.APPLE/com.apple.amsengagementd"; remote = "any"; }
            { action = "deny"; process = "identifier.APPLE/com.apple.icloud.searchpartyuseragent"; remote = "any"; }
            { action = "deny"; process = "identifier.APPLE/com.apple.helpd"; remote = "any"; }
            { action = "deny"; process = "identifier.APPLE/com.apple.storekitagent"; remote = "any"; }
            { action = "deny"; process = "identifier.APPLE/com.apple.ndoagent"; remote = "any"; }
            { action = "deny"; process = "identifier.APPLE/com.apple.ciphermld"; remote = "any"; }
            { action = "deny"; process = "identifier.APPLE/com.apple.parsecd"; remote = "any"; }
            { action = "deny"; process = "identifier.APPLE/com.apple.tipsd"; remote = "any"; }
            { action = "deny"; process = "identifier.APPLE/com.apple.remindd"; remote = "any"; }
            { action = "deny"; process = "identifier.APPLE/com.apple.parsec-fbf"; remote = "any"; }
            { action = "deny"; process = "identifier.APPLE/com.apple.Safari.SafeBrowsing"; remote = "any"; }
            { action = "deny"; process = "identifier.APPLE/com.apple.syspolicyd"; remote = "any"; }
            { action = "deny"; process = "identifier.APPLE/com.apple.cloudd"; remote = "any"; }
            { action = "deny"; process = "identifier.APPLE/com.apple.AddressBookSourceSync"; remote = "any"; }
            { action = "deny"; process = "identifier.APPLE/com.apple.SubmitDiagInfo"; remote = "any"; }
            { action = "deny"; process = "identifier.APPLE/com.apple.amsondevicestoraged"; remote = "any"; }
            { action = "deny"; process = "identifier.APPLE/com.apple.ap.promotedcontentd"; remote = "any"; }
            { action = "deny"; process = "identifier.APPLE/com.apple.cloudtelemetryd"; remote = "any"; }
            { action = "deny"; process = "identifier.APPLE/com.apple.familycircled"; remote-hosts = "setup.icloud.com"; }
            { action = "deny"; process = "identifier.APPLE/com.apple.findmy.findmylocateagent"; remote = "any"; }
            { action = "deny"; process = "identifier.APPLE/com.apple.fpassetmanagerd"; remote = "any"; }
            { action = "deny"; process = "identifier.APPLE/com.apple.geod"; remote = "any"; }
            { action = "deny"; process = "identifier.APPLE/com.apple.geod"; remote = "any"; }
            { action = "deny"; process = "identifier.APPLE/com.apple.networkserviceproxy"; remote = "any"; }
            { action = "deny"; process = "identifier.APPLE/com.apple.rtcreportingd"; remote = "any";}
            { action = "deny"; process = "identifier.APPLE/com.apple.webprivacyd"; remote = "any"; }
          ]

          # Factory rules
          # It's really stupid that I need to do this, but oh well.
          # Little Snitch is good in every other way.
          [
            {
              action = "allow";
              direction = "both";
              disabled = true;
              group = "aaaaac";
              process = "appGroup.macOS";
              remote = "any";
              origin = "factory";
              factoryID = 423;
            }
          ]
          (mkGlobalRuleset {
            action = "allow";
            disabled = true;
            group = "aaaaac";
            remote-domains = [
              "apple"
              "apple-cloudkit.com"
              "apple-mapkit.com"
              "apple.com"
              "apple.news"
              "cdn-apple.com"
              "mzstatic.com"
            ];
            requiresTrustedSignatureForAnyProcess = true;
            origin = "factory";
            factoryID = 421;
          })
          (mkGlobalRuleset {
            action = "allow";
            disabled = true;
            group = "aaaaad";
            ports = "443";
            remote-domains = [
              "icloud-content.com"
              "icloud.com"
            ];
            requiresTrustedSignatureForAnyProcess = true;
            origin = "factory";
            factoryID = 420;
          })
        ];
        /*nixfmt:enable*/
      };
    };
  };
}
