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
  configDir = if isDarwin then "Library/Application Support" else config.xdg.configHome;

  jsonFormat = pkgs.formats.json { };
in
{
  options.programs.discord = {
    moonlight = mkOption {
      inherit (jsonFormat) type;
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
    })
    (mkIf isLinux {
      programs.discord.package = pkgs.discord-canary.override {
        withMoonlight = true;
        moonlight = inputs.moonlight.packages.${system}.moonlight;
      };
    })
    {
      programs.discord = {
        enable = true;
        configName = "discordcanary";

        settings.DANGEROUS_ENABLE_DEVTOOLS_ONLY_ENABLE_IF_YOU_KNOW_WHAT_YOURE_DOING = true;

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

      home.file."${configDir}/${cfg.configName}/settings.json".force = true; # TODO: Discord recently started recreating(?) this file at runtime so home-manager thinks it'll be "clobbered", contribute upstream?
      home.file."${configDir}/moonlight-mod/canary.json".source =
        jsonFormat.generate "moonlight-settings.json" cfg.moonlight;
    }
  ]);
}
