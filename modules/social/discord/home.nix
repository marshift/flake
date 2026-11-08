{
  inputs,
  lib,
  pkgs,
  osConfig,
  config,
  ...
}:
let
  inherit (lib.modules) mkIf mkMerge;
  inherit (lib.options) mkOption;
  inherit (pkgs.stdenv.hostPlatform) isLinux isDarwin system;

  cfg = config.programs.discord;
  settingsFormat = pkgs.formats.json { };
in
{
  options.programs.discord = {
    moonlight = mkOption {
      inherit (settingsFormat) type;
      default = { };
      description = "moonlight settings.";
    };
  };

  config = mkIf osConfig.swamp.social.discord.enable (mkMerge [
    (mkIf isDarwin {
      programs.discord = {
        package = null;
        settings = {
          UPDATE_ENDPOINT = "https://inject.shelter.uwu.network/moonlight";
          NEW_UPDATE_ENDPOINT = "https://inject.shelter.uwu.network/moonlight/";
        };
      };
      home.file."Library/Application Support/moonlight-mod/canary.json" = {
        source = settingsFormat.generate "moonlight-settings.json" cfg.moonlight;
        force = true;
      };
    })

    (mkIf isLinux {
      programs.discord.package = pkgs.discord-canary.override {
        withMoonlight = true;
        moonlight = inputs.moonlight.packages.${system}.moonlight;
      };
      xdg.configFile."moonlight-mod/canary.json" = {
        source = settingsFormat.generate "moonlight-settings.json" cfg.moonlight;
        force = true;
      };
    })

    {
      programs.discord = {
        enable = true;
        configName = "discordcanary";

        settings = {
          DANGEROUS_ENABLE_DEVTOOLS_ONLY_ENABLE_IF_YOU_KNOW_WHAT_YOURE_DOING = true;
        };

        moonlight = {
          extensions = {
            moonbase = true;
            noTrack = true;
            noHideToken = true;
            disableSentry = true;

            spacepack = {
              enabled = true;
              config.addToGlobalScope = true;
            };

            experiments = {
              enabled = true;
              config.staffSettings = true;
            };

            noHelp = true;
            jumpToBlocked = true;
            resolver = true;
            silenceTyping = true;
          };

          repositories = [ "https://moonlight-mod.github.io/extensions-dist/repo.json" ];
        };
      };
    }
  ]);
}
