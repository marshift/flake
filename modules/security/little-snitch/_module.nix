{
  lib,
  pkgs,
  config,
  ...
}:
let
  # Deliberately being frugal with inherits here because logic in this file gets complex
  inherit (pkgs) writeText;
  inherit (lib.options) mkOption mkEnableOption;
  inherit (lib.types)
    submodule
    bool
    nullOr
    str
    enum
    int
    listOf
    oneOf
    ;
  inherit (lib.modules) mkIf mkAfter;

  littleSnitchList = oneOf [
    str
    (listOf str)
  ];

  preferencesType = submodule {
    options = {
      activeSilentMode = mkOption {
        type = int;
        description = "If silent mode is active or not.";
        default = 0;
      };

      allowCommandLineAccess = mkOption {
        type = int;
        description = "If command line access should be allowed to modify Little Snitch (disabling this will break Nix's ability to update configuration).";
        default = 1;
      };

      firstLaunchDate6 = mkOption {
        type = str;
        description = "First time that Little Snitch was launched.";
        default = "1970-01-01T00:00:00Z";
      };

      # TODO: What does this do?
      globalLastShownWelcomeWindowVersion = mkOption {
        type = int;
        default = 2;
      };

      markNewBlocklistEntriesAsUnapproved = mkOption {
        type = int;
        description = "Rules made from the Little Snitch UI will be marked as unapproved at first.";
        default = 1;
      };

      monitorMaxConnectionsInModel = mkOption {
        type = int;
        description = "The maximum amount of connections shown in the monitor UI.";
        default = 50000;
      };

      networkFilterControlBits = mkOption {
        type = int;
        description = "Bitflag that controls the Little Snitch network monitor, undocumented and unknown.";
        default = 53087074189319;
      };

      networkFilterEnabled = mkOption {
        type = int;
        description = "If the Little Snitch network filter should be enabled.";
        default = 1;
      };

      allowGUIScripting = mkOption {
        type = int;
        description = "If GUI scripting modifying Little Snitch should be allowed.";
        default = 0;
      };

      allowGlobalEditing = mkOption {
        type = int;
        description = "If global rules should be allowed to be modified (disabling this will break Nix's ability to update configuration).";
        default = 1;
      };

      allowProfileSwitching = mkOption {
        type = int;
        description = "Allow the use of profile switching.";
        default = 0;
      };

      allowRuleAndProfileEditing = mkOption {
        type = int;
        description = "If rules and profiles should be allowed to be modified (disabling this will break Nix's ability to update rules).";
        default = 1;
      };

      allowSettingsEditing = mkOption {
        type = int;
        description = "If settings should be allowed to be modified (disabling this will break Nix's ability to update settings).";
        default = 1;
      };

      approveRulesAutomatically = mkOption {
        type = int;
        description = "If unapproved rules should be approved automatically.";
        default = 0;
      };

      # TODO: autoConfirmationAction (unknown enum), autoConfirmationDelay (seconds), confirmAutomatically (bool)

      confirmWithReturnKey = mkOption {
        type = int;
        description = "If network alerts can be confirmed with the return key.";
        default = 0;
      };

      detailLevelPortAndProtocol = mkOption {
        type = int;
        description = "The level of detail ports and protocols should be displayed in the alert UI.";
        default = 1;
      };

      # TODO: Invalid integer in Nix...
      # TODO: What does this enum contain, anyway?
      #enabledUserNotificationTypes = mkOption {
      #  type = int;
      #  default = 18446744073709551615;
      #};

      markNewRulesAsUnapproved = mkOption {
        type = int;
        description = "If new rules should automatically be marked as unapproved by default.";
        default = 1;
      };

      menuBarExtraBlockedConnectionStyle = mkOption {
        type = int;
        description = "The menu bar blocked connections style (0: off, 1: monochrome, 2: coloured).";
        default = 1;
      };

      menuBarExtraInactivityWarningStyle = mkOption {
        type = int;
        description = "The menu bar inactivity warning style (0: off, 1: monochrome, 2: coloured).";
        default = 1;
      };

      menuBarExtraIsShown = mkOption {
        type = int;
        description = "If extra information in the menu bar should be shown.";
        default = 1;
      };

      menuBarExtraNumericDataRateStyle = mkOption {
        type = int;
        description = "The menu bar number traffic rate style (0: off, 1: monochrome, 2: coloured).";
        default = 1;
      };

      menuBarExtraSilentModeStyle = mkOption {
        type = int;
        description = "The menu bar indicator for silent mode (0: off, 1: checkmark, 2: checkmark, coloured).";
        default = 1;
      };

      menuBarExtraTrafficMeterStyle = mkOption {
        type = int;
        description = "The menu bar icon (0: off, 1: history in last 5 minutes, 2: current 3: current, coloured).";
        default = 3;
      };

      monitorAndAgentShowLocalnetTraffic = mkOption {
        type = int;
        description = "If local network traffic should be shown in the Little Snitch network monitor and agent UIs.";
        default = 0;
      };

      monitorHotKey = mkOption {
        type = str;
        description = "The hotkey to open the Little Snitch network monitor.";
        default = "6400@46";
      };

      monitorHotKeyEnabled = mkOption {
        type = int;
        description = "If the hotkey to open the Little Snitch network monitor should be enabled.";
        default = 1;
      };

      monitorMyLocationUpdateMode = mkOption {
        type = int;
        description = "The local device location update mode for the network location mode (0: off, 1: on).";
        default = 0;
      };

      monitorShowLastMinutes = mkOption {
        type = int;
        description = "The duration in minutes to show connections in the Little Snitch network monitor.";
        default = 10080;
      };

      monitorShowMyLocationBanner = mkOption {
        type = int;
        description = "If the \"Show my location\" banner should be shown in the Little Snitch network monitor.";
        default = 0;
      };

      monitorShowNEConnections = mkOption {
        type = int;
        description = "If the Little Snitch network monitor should show connections made by macOS network extensions.";
        default = 1;
      };

      monitorShowUnownedConnections = mkOption {
        type = int;
        description = "If the Little Snitch network monitor should show connections made by unknown sources.";
        default = 1;
      };

      monitorTrafficMeterStyle = mkOption {
        type = int;
        description = "The style of the traffic meter in the Little Snitch network monitor (0: monochrome, 1: coloured).";
        default = 1;
      };

      # TODO: Unknown
      pidOfLSCShowingWelcomeWindow = mkOption {
        type = int;
        default = 0;
      };

      # TODO: Unknown
      respectMyPrivacy = mkOption {
        type = int;
        default = 1;
      };

      selectFullHostnameByDefault = mkOption {
        type = int;
        description = "If the Little Snitch alert window should show the full host name instead of domain by default.";
        default = 1;
      };

      useActiveProfileWhenCreatingRulesInAlert = mkOption {
        type = int;
        description = "If the Little Snitch alert window should use the active profile while creating rules.";
        default = 1;
      };
    };
  };

  # https://help.obdev.at/littlesnitch6/adv-lsrules-file-format
  ruleType = submodule {
    options = {
      process = mkOption {
        type = nullOr str;
        description = "The process to match, \"any\" if the rule should match any process.";
        default = null;
      };

      via = mkOption {
        type = nullOr str;
        description = "If the rule should only match if the executable uses a specific helper tool.";
        default = null;
      };

      remote-addresses = mkOption {
        type = nullOr str;
        description = "The remote addresses to match, containing one or more IP addresses or ranges (split by \", \").";
        default = null;
      };

      remote-hosts = mkOption {
        type = nullOr littleSnitchList;
        description = "The remote hosts to match (split by \", \").";
        default = null;
      };

      remote-domains = mkOption {
        type = nullOr littleSnitchList;
        description = "The remote domains to match.";
        default = null;
      };

      remote = mkOption {
        type = nullOr (enum [
          "any"
          "local-net"
          "multicast"
          "broadcast"
          "bonjour"
          "dns-servers"
          "bpf"
        ]);
        description = "The remote type.";
        default = null;
      };

      direction = mkOption {
        type = enum [
          "incoming"
          "outgoing"
          "both"
        ];
        description = "The connection direction.";
        default = "outgoing";
      };

      action = mkOption {
        type = enum [
          "allow"
          "deny"
          "ask"
        ];
        description = "The rule action.";
        default = "ask";
      };

      priority = mkOption {
        type = enum [
          "regular"
          "high"
        ];
        description = "The rule priority.";
        default = "regular";
      };

      disabled = mkOption {
        type = bool;
        description = "If the rule should be disabled by default.";
        default = false;
      };

      ports = mkOption {
        type = nullOr str;
        description = "The ports the rule matches a single port (e.g. \"443\"), or a range of ports (e.g. \"123-456\").";
        default = null;
      };

      protocol = mkOption {
        type = nullOr str;
        description = "The protocol the rule matches. Can be a numeric value as defined in /etc/protocols, like \"6\" for TCP, or the actual protocol name, like \"tcp\". Defaults to any protocol.";
        default = null;
      };

      notes = mkOption {
        type = nullOr str;
        description = "The notes for the rule.";
        default = null;
      };

      # TODO: Undocumented
      group = mkOption {
        type = nullOr str;
        description = "The preset group this rule was created for.";
        default = null;
      };

      requiresTrustedSignatureForAnyProcess = mkOption {
        type = bool;
        description = "The \"any\" process matching target must have a trusted signature.";
        default = false;
      };

      approved = mkOption {
        type = bool;
        description = "If the rule was approved or not by the user.";
        default = true;
      };

      origin = mkOption {
        type = str; # Untyped enum
        description = "The origin of this rule.";
        default = "frontend";
      };

      owner = mkOption {
        type = nullOr str; # Untyped enum of "usernames"
        description = "The owner of this rule.";
        default = null;
      };

      factoryID = mkOption {
        type = nullOr int;
        description = "The factory rule identifier.";
        default = null;
      };

      protected = mkOption {
        type = bool;
        description = "If the rule should be protected (non-removable) or not.";
        default = true;
      };

      uid = mkOption {
        type = nullOr int;
        description = "The unix user ID of the macOS user for this rule.";
        default = null;
      };
    };
  };

  userType = submodule {
    options = {
      fullName = mkOption {
        type = str;
        description = "The full name of the macOS user.";
      };

      shortName = mkOption {
        type = str;
        description = "The unix username of the macOS user.";
      };

      uid = mkOption {
        type = int;
        description = "The unix user ID of the macOS user.";
      };

      defaults = mkOption {
        type = preferencesType;
        description = "The preferences/defaults that will be applied for this specific user.";
        default = { };
      };
    };
  };

  cfg = config.services.little-snitch;

  exportJsonFile = writeText "little-snitch-export.json" (lib.strings.toJSON cfg.config);
in
{
  options.services.little-snitch = {
    enable = mkEnableOption "Little Snitch firewall";

    config = {
      globalDefaults = mkOption {
        type = preferencesType;
        description = "Little Snitch preferences/defaults that will be applied gllobally.";
        default = { };
      };

      groups = mkOption {
        type = (pkgs.formats.json { }).type;
        description = "Little Snitch preset groups.";
        default = {
          aaaaac = {
            type = "builtinMacOSServices";
            lastUpdateInvalidDomainsCount = 0;
            updateInterval = 86400;
          };
          aaaaad = {
            type = "builtinICloudServices";
            lastUpdateInvalidDomainsCount = 0;
            updateInterval = 86400;
          };
        };
      };

      rules = mkOption {
        type = listOf ruleType;
        description = "The Little Snitch rules that will be applied.";
        default = [ ];
      };

      users = mkOption {
        type = listOf userType;
        description = "The macOS user-specific Little Snitch configurations.";
        default = [ ];
      };
    };
  };

  config = mkIf cfg.enable {
    # TODO: Only restart Little Snitch on changes?
    system.activationScripts.postActivation.text = mkAfter ''
      echo "setting up Little Snitch firewall..."
      "/Applications/Little Snitch.app/Contents/Components/littlesnitch" restore-model ${exportJsonFile}
    '';
  };
}
