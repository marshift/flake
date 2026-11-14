{
  lib,
  pkgs,
  osConfig,
  ...
}:
lib.modules.mkIf (osConfig.swamp.desktop.wayle.enable && pkgs.stdenv.hostPlatform.isLinux) {
  services.wayle = {
    enable = true;
    autoInstallDependencies = false;

    settings = {
      wallpaper.engine-enabled = false;
      styling.scale = 1;

      bar = {
        scale = 0.85;

        border-location = "bottom";
        shadow = "drop";

        button-variant = "basic";
        button-label-weight = "medium";

        dropdown-freeze-label = false;

        layout = [
          {
            monitor = "*";
            show = true;

            left = lib.lists.optional osConfig.swamp.desktop.niri.enable "niri-workspaces";
            center = [ ];
            right = [
              "systray"
              "cava"
              "volume"
              "bluetooth"
              "network"
              "idle-inhibit"
              "battery"
              "clock"
              "notifications"
            ];
          }
        ];
      };

      modules = {
        battery = {
          icon-color = "accent";
          label-color = "fg-default";
        };

        bluetooth = {
          icon-bg-color = "accent";
          label-show = false;
        };

        cava = {
          bar-width = 4;
          bars = 8;
          direction = "mirror";
          framerate = 144;
          left-click = "dropdown:media";
        };

        clock = {
          format = "%H:%M";
          icon-show = false;
          label-color = "fg-default";
          right-click = "";
        };

        idle-inhibit = {
          icon-color = "accent";
          label-show = false;
          right-click = "";
        };

        network = {
          icon-color = "accent";
          label-show = false;
        };

        niri-workspaces = {
          app-icons-dedupe = false;
          app-icons-show = true;
          display-mode = "none";
          hide-trailing-empty = false;
          occupied-color = "accent";
          urgent-mode = "application";
        };

        notifications = {
          icon-color = "accent";
          label-show = false;
          popup-close-behavior = "remove";
          popup-urgency-bar = "none";
        };

        systray = {
          icon-scale = 1.25;
          item-gap = 0.5;
        };

        volume = {
          icon-color = "accent";
          label-show = false;
        };
      };
    };
  };
}
