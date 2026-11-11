{
  lib,
  pkgs,
  osConfig,
  config,
  ...
}:
lib.modules.mkIf (osConfig.swamp.desktop.waybar.enable && pkgs.stdenv.hostPlatform.isLinux) {
  stylix.targets.waybar.fonts.enable = false; # WHy does it use the mono font???
  programs.waybar = {
    enable = true;
    systemd.enable = true;

    settings = {
      main = {
        layer = "top";
        position = "top";
        height = 32;

        clock.tooltip-format = "{:%d/%m/%Y}";

        battery.format = "battery {capacity}%";

        temperature = {
          format = "temperature {temperatureC}°C";
          tooltip = false;
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
        border-bottom: 1px solid ${base0D};
      }

      .modules-left {
        margin-left: 0.5rem;
      }

      .modules-right {
        margin-right: 0.5rem;
      }

      #workspaces button {
        border-radius: unset;
      }

      #tray widget > image {
        margin-left: 0.25rem;
        margin-right: 0.25rem;
      }
    '';
  };
}
