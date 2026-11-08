{
  lib,
  pkgs,
  osConfig,
  config,
  ...
}:
let
  inherit (lib.modules) mkIf;
  inherit (lib.meta) getExe getExe';
  inherit (lib.attrsets) optionalAttrs;

  desktopCfg = osConfig.swamp.desktop;
  programCfg = config.programs;

  swayosdClient = getExe' config.services.swayosd.package "swayosd-client";
in
mkIf (osConfig.swamp.desktop.niri.enable && pkgs.stdenv.hostPlatform.isLinux) {
  programs.niri = {
    settings = {
      prefer-no-csd = true;
      screenshot-path = null;

      input = {
        keyboard.xkb.layout = osConfig.environment.variables.XKB_DEFAULT_LAYOUT;
        mouse.accel-profile = "flat";
        focus-follows-mouse.enable = true;
      };

      layout = {
        gaps = 8;
        border = {
          enable = true;
          width = 1;
        };

        focus-ring.enable = false;

        preset-column-widths = [
          { proportion = 0.25; }
          { proportion = 0.5; }
          { proportion = 0.75; }
          { proportion = 1.0; }
        ];
        default-column-width.proportion = 1.0;
      };

      window-rules = [
        {
          draw-border-with-background = false;
          clip-to-geometry = true;
          geometry-corner-radius =
            let
              r = 8.0;
            in
            {
              top-left = r;
              top-right = r;
              bottom-left = r;
              bottom-right = r;
            };
        }
      ];

      hotkey-overlay.skip-at-startup = true;
      # These assume I'll never have monitors on a vertical axis... I probably won't.
      binds =
        with config.lib.niri.actions;
        {
          # Positions
          "Mod+Left".action = focus-column-or-monitor-left;
          "Mod+Down".action = focus-window-down;
          "Mod+Up".action = focus-window-up;
          "Mod+Right".action = focus-column-or-monitor-right;
          "Mod+Ctrl+Left".action = move-column-left-or-to-monitor-left;
          "Mod+Ctrl+Down".action = move-window-down;
          "Mod+Ctrl+Up".action = move-window-up;
          "Mod+Ctrl+Right".action = move-column-right-or-to-monitor-right;
          "Mod+Shift+Down".action = focus-workspace-down;
          "Mod+Shift+Up".action = focus-workspace-up;
          "Mod+Shift+Ctrl+Down".action = move-column-to-workspace-down;
          "Mod+Shift+Ctrl+Up".action = move-column-to-workspace-up;
          "Mod+Alt+Ctrl+Down".action = move-workspace-down;
          "Mod+Alt+Ctrl+Up".action = move-workspace-up;

          # Sizes
          "Mod+Comma".action = consume-or-expel-window-left;
          "Mod+Period".action = consume-or-expel-window-right;
          "Mod+Minus".action = set-column-width "-10%";
          "Mod+Equal".action = set-column-width "+10%";
          "Mod+Shift+Minus".action = set-window-height "-10%";
          "Mod+Shift+Equal".action = set-window-height "+10%";
          "Mod+R".action = switch-preset-column-width;
          "Mod+F".action = maximize-column;
          "Mod+Shift+F".action = fullscreen-window;
          "Mod+C".action = center-column;

          # Scroll wheel
          # TODO: Trackpad
          "Mod+WheelScrollDown" = {
            cooldown-ms = 150;
            action = focus-workspace-down;
          };
          "Mod+WheelScrollUp" = {
            cooldown-ms = 150;
            action = focus-workspace-up;
          };
          "Mod+Ctrl+WheelScrollDown" = {
            cooldown-ms = 150;
            action = move-column-to-workspace-down;
          };
          "Mod+Ctrl+WheelScrollUp" = {
            cooldown-ms = 150;
            action = move-column-to-workspace-up;
          };
          "Mod+Shift+WheelScrollDown".action = focus-column-or-monitor-right;
          "Mod+Shift+WheelScrollUp".action = focus-column-or-monitor-left;
          "Mod+Shift+Ctrl+WheelScrollDown".action = move-column-right-or-to-monitor-right;
          "Mod+Shift+Ctrl+WheelScrollUp".action = move-column-left-or-to-monitor-left;

          # Screenshots
          "Mod+S".action.screenshot = [ ];
          "Mod+Shift+S".action.screenshot-window = [ ];
          "Mod+Ctrl+Shift+S".action.screenshot-screen = [ ];

          # Power
          "Mod+Q".action = close-window;
          "Mod+Shift+P".action = power-off-monitors;
          "Mod+Shift+E".action = quit;

        }
        // optionalAttrs desktopCfg.ghostty.enable {
          "Mod+Return".action.spawn = "${getExe programCfg.ghostty.package}";
        }
        // optionalAttrs desktopCfg.fuzzel.enable {
          "Mod+Space".action.spawn = "${getExe programCfg.fuzzel.package}";
        }
        // optionalAttrs desktopCfg.swaylock.enable {
          "Mod+L".action.spawn = "${getExe programCfg.swaylock.package}";
        }
        // optionalAttrs desktopCfg.swayosd.enable {
          /*nixfmt:disable*/
          # Brightness
          "XF86MonBrightnessUp".action.spawn = [ swayosdClient "--brightness" "raise" ];
          "XF86MonBrightnessDown".action.spawn = [ swayosdClient "--brightness" "lower" ];

          # Volume
          "XF86AudioRaiseVolume".action.spawn = [ swayosdClient "--output-volume" "raise" ];
          "XF86AudioLowerVolume".action.spawn = [ swayosdClient "--output-volume" "lower" ];
          "XF86AudioMute".action.spawn = [ swayosdClient "--output-volume" "mute-toggle" ];
          "Shift+XF86AudioMute".action.spawn = [ swayosdClient "--input-volume" "mute-toggle" ];

          # Playback
          "XF86AudioPlay".action.spawn = [ swayosdClient "--playerctl" "play-pause" ];
          "XF86AudioNext".action.spawn = [ swayosdClient "--playerctl" "next" ];
          "XF86AudioPrev".action.spawn = [ swayosdClient "--playerctl" "prev" ];
          /*nixfmt:enable*/
        };
    };
  };
}
