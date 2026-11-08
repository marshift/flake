{
  lib,
  pkgs,
  osConfig,
  config,
  ...
}:
lib.modules.mkIf (osConfig.swamp.desktop.waybar.enable && pkgs.stdenv.hostPlatform.isLinux) {
  programs.waybar = {
    enable = true;
    systemd.enable = true;

    settings = {
      main = {
        layer = "top";
        position = "top";
        height = 32;

        "clock" = {
          tooltip = false;
        };
        "battery" = {
          format = "battery {capacity}%";
        };
        "temperature" = {
          format = "temperature {temperatureC}°C";
        };

        modules-left = lib.lists.optionals osConfig.swamp.desktop.niri.enable [
          "niri/workspaces"
        ];
        modules-center = [ "clock" ];
        modules-right = [
          "temperature"
          "battery"
          "tray"
        ];
      };
    };

    style = with config.lib.stylix.colors.withHashtag; ''
      * {
        font-family: ${config.stylix.fonts.sansSerif.name};
        font-size: 14px;
        font-weight: 500;
      }

      window#waybar {
        color: ${base05};
        background-color: ${base00};
        border-bottom: 1px solid ${base0D};
      }

      .modules-left {
        margin-left: 0.5rem;
      }

      .modules-right {
        margin-right: 0.5rem;
      }

      #tray widget > image {
        margin-left: 0.25rem;
        margin-right: 0.25rem;
      }
    '';
  };
}
