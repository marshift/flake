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
      services.xwayland-satellite = {
        enable = true;
        targetService = "niri.service";
        execStart = lib.getExe inputs.niri.packages.${system}.xwayland-satellite;
      };
    };

    programs.niri = {
      enable = true;
      package = pkgs.niri-unstable;
      settings = {
        inherit outputs;
        environment = {
          DISPLAY = ":0";
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
            sh = spawn "sh" "-c";
          in
          {
            "Mod+Shift+Slash".action = show-hotkey-overlay;
            "Mod+Return".action.spawn = "${lib.getExe pkgs.foot}";
            "Mod+D".action = sh "${lib.getExe pkgs.fuzzel}";
            "Mod+Q".action = close-window;
            "Mod+Left".action = focus-column-left;
            "Mod+Down".action = focus-window-down;
            "Mod+Up".action = focus-window-up;
            "Mod+Right".action = focus-column-right;
            "Mod+H".action = focus-column-left;
            "Mod+J".action = focus-window-down;
            "Mod+K".action = focus-window-up;
            "Mod+L".action = focus-column-right;
            "Mod+Ctrl+Left".action = move-column-left;
            "Mod+Ctrl+Down".action = move-window-down;
            "Mod+Ctrl+Up".action = move-window-up;
            "Mod+Ctrl+Right".action = move-column-right;
            "Mod+Ctrl+H".action = move-column-left;
            "Mod+Ctrl+J".action = move-window-down;
            "Mod+Ctrl+K".action = move-window-up;
            "Mod+Ctrl+L".action = move-column-right;
            "Mod+Tab".action = focus-window-down-or-column-right;
            "Mod+Shift+Tab".action = focus-window-up-or-column-left;
            "Mod+Home".action = focus-column-first;
            "Mod+End".action = focus-column-last;
            "Mod+Ctrl+Home".action = move-column-to-first;
            "Mod+Ctrl+End".action = move-column-to-last;
            "Mod+Page_Down".action = focus-workspace-down;
            "Mod+Page_Up".action = focus-workspace-up;
            "Mod+Ctrl+Page_Down".action = move-column-to-workspace-down;
            "Mod+Ctrl+Page_Up".action = move-column-to-workspace-up;
            "Mod+Shift+Page_Down".action = move-workspace-down;
            "Mod+Shift+Page_Up".action = move-workspace-up;
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
            "Mod+Shift+WheelScrollDown".action = focus-column-right;
            "Mod+Shift+WheelScrollUp".action = focus-column-left;
            "Mod+Ctrl+Shift+WheelScrollDown".action = move-column-right;
            "Mod+Ctrl+Shift+WheelScrollUp".action = move-column-left;
            "Mod+Comma".action = consume-window-into-column;
            "Mod+Period".action = expel-window-from-column;
            "Mod+R".action = switch-preset-column-width;
            "Mod+F".action = maximize-column;
            "Mod+Shift+F".action = fullscreen-window;
            "Mod+C".action = center-column;
            "Mod+Minus".action = set-column-width "-10%";
            "Mod+Equal".action = set-column-width "+10%";
            "Mod+Shift+Minus".action = set-window-height "-10%";
            "Mod+Shift+Equal".action = set-window-height "+10%";
            "Print".action = screenshot;
            "Ctrl+Print".action = screenshot-screen;
            "Alt+Print".action = screenshot-window;
            "Mod+Shift+E".action = quit;
            "Mod+Shift+P".action = power-off-monitors;
          };
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
