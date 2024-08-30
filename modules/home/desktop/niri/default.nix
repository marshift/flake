{ config, lib, inputs, system, pkgs, ... }:

lib.habitat.mkModule {
  inherit config;
  path = [ "home" "desktop" "niri" ];
  extraOptions = {
    outputs = lib.mkOption { type = lib.types.attrs; };
    keyboardLayout = lib.mkOption { type = lib.types.str; };
  };
  output = with config.habitat.home.desktop.niri; {
    habitat.home = {
      services = {
        xwayland-satellite = {
          enable = true;
          targetService = "niri.service";
        };
        swaybg = {
          enable = true;
          targetService = "niri.service";
        };
        waybar = {
          enable = true;
          targetService = "niri.service";
        };
      };
    };

    programs.niri = {
      enable = true;
      package = pkgs.niri-unstable;
      settings = {
        inherit outputs;
        environment = {
          DISPLAY = ":0";
          NIXOS_OZONE_WL = "1";
        };
        input = {
          keyboard = {
            xkb = {
              layout = keyboardLayout;
            };
          };
          mouse = {
            accel-profile = "flat";
          };
          focus-follows-mouse.enable = true;
        };
        layout = {
          gaps = 8;
          preset-column-widths = [
            { proportion = 0.25; }
            { proportion = 0.5; }
            { proportion = 0.75; }
            { proportion = 1.0; }
          ];
          default-column-width = {
            proportion = 1.0;
          };
          focus-ring = {
            enable = false;
          };
          border = {
            enable = true;
            width = 2;
          };
        };
        prefer-no-csd = true;
        screenshot-path = null;
        hotkey-overlay.skip-at-startup = true;
        binds =
          with config.lib.niri.actions;
          let
            desktopPrograms = config.habitat.home.desktop;
          in
          lib.mergeAttrsList [
            # TODO: These are *still* not laptop compatible
            # Also, they assume I'll never have monitors on a vertical axis.
            # ...Which I probably won't..
            {
              "Mod+Left".action = focus-column-or-monitor-left;
              "Mod+Down".action = focus-window-down;
              "Mod+Up".action = focus-window-up;
              "Mod+Right".action = focus-column-or-monitor-right;
              "Mod+Ctrl+Left".action = move-column-left-or-to-monitor-left;
              "Mod+Ctrl+Down".action = move-window-down;
              "Mod+Ctrl+Up".action = move-window-up;
              "Mod+Ctrl+Right".action = move-column-right-or-to-monitor-right;
              "Mod+Home".action = focus-column-first;
              "Mod+End".action = focus-column-last;
              "Mod+Ctrl+Home".action = move-column-to-first;
              "Mod+Ctrl+End".action = move-column-to-last;
              "Mod+Page_Down".action = focus-workspace-down;
              "Mod+Page_Up".action = focus-workspace-up;
              "Mod+Shift+Page_Down".action = move-workspace-down;
              "Mod+Shift+Page_Up".action = move-workspace-up;
              "Mod+Ctrl+Page_Down".action = move-column-to-workspace-down;
              "Mod+Ctrl+Page_Up".action = move-column-to-workspace-up;
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
              "Mod+Q".action = close-window;
              "Mod+Shift+E".action = quit;
              "Mod+Shift+P".action = power-off-monitors;
            }
            # Scroll wheel
            # TODO: Trackpad?
            {
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
              "Mod+Ctrl+Shift+WheelScrollDown".action = move-column-right-or-to-monitor-right;
              "Mod+Ctrl+Shift+WheelScrollUp".action = move-column-left-or-to-monitor-left;
            }
            # Screenshots
            {
              "Print".action = screenshot;
              "Ctrl+Print".action = screenshot-screen;
              "Alt+Print".action = screenshot-window;
            }
            # Foot terminal support
            (lib.optionalAttrs desktopPrograms.foot.enable {
              "Mod+Return".action.spawn = "${lib.getExe config.programs.foot.package}";
            })
            # Fuzzel support
            (lib.optionalAttrs desktopPrograms.fuzzel.enable {
              "Mod+D".action.spawn = "${lib.getExe config.programs.fuzzel.package}";
            })
          ];
        window-rules = [
          {
            draw-border-with-background = false;
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
            clip-to-geometry = true;
          }
        ];
      };
    };
  };
}
