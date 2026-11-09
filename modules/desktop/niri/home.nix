{
  inputs,
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
      environment.DISPLAY = ":0";
      xwayland-satellite.path =
        getExe
          inputs.niri-flake.packages.${pkgs.stdenv.hostPlatform.system}.xwayland-satellite-unstable;

      screenshot-path = null;

      # Style
      prefer-no-csd = true;

      layout = {
        gaps = 8;

        border.width = 1;
        focus-ring.width = 1;

        preset-column-widths = [
          { proportion = 0.25; }
          { proportion = 0.5; }
          { proportion = 0.75; }
          { proportion = 1.0; }
        ];
        default-column-width.proportion = 1.0;

        background-color = "transparent";
      };

      overview.workspace-shadow.enable = false;

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

      layer-rules = [
        {
          matches = [
            {
              layer = "background"; # Should this be scoped to specifically the wallpaper?
            }
          ];
          place-within-backdrop = true;
        }
      ];

      # Input
      input = {
        keyboard.xkb.layout = osConfig.environment.variables.XKB_DEFAULT_LAYOUT;

        mouse.accel-profile = "flat";
        touchpad = {
          tap = true;
          natural-scroll = true;
        };

        focus-follows-mouse.enable = true;
      };

      hotkey-overlay.skip-at-startup = true;
      binds =
        with config.lib.niri.actions;
        # These assume I'll never have monitors on a vertical axis... I probably won't.
        {
          # Simple window management
          "Mod+Left".action = focus-column-or-monitor-left;
          "Mod+Down".action = focus-window-or-workspace-down;
          "Mod+Up".action = focus-window-or-workspace-up;
          "Mod+Right".action = focus-column-or-monitor-right;

          "Mod+Shift+WheelScrollUp".action = focus-column-or-monitor-left;
          "Mod+WheelScrollDown".action = focus-window-or-workspace-down;
          "Mod+WheelScrollUp".action = focus-window-or-workspace-up;
          "Mod+Shift+WheelScrollDown".action = focus-column-or-monitor-right;

          "Mod+Shift+Left".action = move-column-left-or-to-monitor-left;
          "Mod+Shift+Down".action = move-window-down-or-to-workspace-down;
          "Mod+Shift+Up".action = move-window-up-or-to-workspace-up;
          "Mod+Shift+Right".action = move-column-right-or-to-monitor-right;
          "Mod+Shift+Alt+Down".action = move-workspace-down;
          "Mod+Shift+Alt+Up".action = move-workspace-up;

          "Mod+Minus".action = set-column-width "-10%";
          "Mod+Equal".action = set-column-width "+10%";
          "Mod+Shift+Minus".action = set-window-height "-10%";
          "Mod+Shift+Equal".action = set-window-height "+10%";

          "Mod+R".action = switch-preset-column-width;
          "Mod+F".action = maximize-column;
          "Mod+Shift+F".action = fullscreen-window;

          "Mod+Q".action = close-window;

          # Advanced window management
          "Mod+Comma".action = consume-or-expel-window-left;
          "Mod+Period".action = consume-or-expel-window-right;

          "Mod+C".action = center-column;
          "Mod+Shift+C".action = center-visible-columns;

          "Mod+D".action = switch-focus-between-floating-and-tiling;
          "Mod+Shift+D".action = toggle-window-floating;

          # Screenshots
          "Mod+S".action.screenshot = [ ];
          "Mod+Shift+S".action.screenshot-window = [ ];
          "Mod+Ctrl+Shift+S".action.screenshot-screen = {
            show-pointer = false;
          };

          # Other
          "Mod+Shift+O".action = toggle-overview;
          "Mod+Shift+Escape".action = toggle-keyboard-shortcuts-inhibit;
          "Mod+Shift+P".action = power-off-monitors;
          "Mod+Shift+L".action = quit;
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

          # Keyboard backlight
          # TODO: SwayOSD's built-in keyboard backlight handling doesn't seem to work for me...
          # https://github.com/ErikReider/SwayOSD/issues/218
          "Shift+XF86MonBrightnessUp".action.spawn = [ swayosdClient "--device" "kbd_backlight" "--brightness" "raise" ];
          "Shift+XF86MonBrightnessDown".action.spawn = [ swayosdClient "--device" "kbd_backlight" "--brightness" "lower" ];

          # Output volume
          "XF86AudioRaiseVolume".action.spawn = [ swayosdClient "--output-volume" "raise" ];
          "XF86AudioLowerVolume".action.spawn = [ swayosdClient "--output-volume" "lower" ];
          "XF86AudioMute".action.spawn = [ swayosdClient "--output-volume" "mute-toggle" ];

          # Input volume
          "Shift+XF86AudioRaiseVolume".action.spawn = [ swayosdClient "--input-volume" "raise" ];
          "Shift+XF86AudioLowerVolume".action.spawn = [ swayosdClient "--input-volume" "lower" ];
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
