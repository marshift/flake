{
  lib,
  pkgs,
  osConfig,
  ...
}:
let
  inherit (lib.meta) getExe;
in
lib.modules.mkIf (osConfig.swamp.desktop.labwc.enable && pkgs.stdenv.hostPlatform.isLinux) {
  wayland.windowManager.labwc = {
    enable = true;

    rc = {
      core = {
        autoEnableOutputs = "no"; # Managed by kanshi
        primarySelection = "no"; # No middle-click-paste
      };

      windowSwitcher = {
        "@preview" = "no";
        "@outlines" = "no";
        "@order" = "age";
        osd = {
          "@style" = "thumbnail";
          "@output" = "cursor";
        };
      };

      resize.popupShow = "Always";

      keyboard = {
        default = true;

        keybind = [
          {
            "@key" = "W-space";
            action = {
              "@name" = "Execute";
              command = "noctalia msg panel-toggle launcher";
            };
          }
          {
            "@key" = "W-return";
            action = {
              "@name" = "Execute";
              command = "ghostty";
            };
          }
          {
            "@key" = "W-l";
            action = {
              "@name" = "Execute";
              command = "swaylock";
            };
          }

          {
            "@key" = "Print";
            action = {
              "@name" = "Execute";
              # TODO: Don't hardcode the colours here
              command = "sh -c '${getExe pkgs.grim} -c -g \"$(${getExe pkgs.slurp} -c FF0A88FF -s 00000000 -b 000000CC)\" - | ${pkgs.wl-clipboard}/bin/wl-copy'";
            };
          }

          # Multimedia keys
          {
            "@key" = "XF86AudioRaiseVolume";
            action = {
              "@name" = "Execute";
              command = "noctalia msg volume-up";
            };
          }
          {
            "@key" = "XF86AudioLowerVolume";
            action = {
              "@name" = "Execute";
              command = "noctalia msg volume-down";
            };
          }
          {
            "@key" = "XF86AudioMute";
            action = {
              "@name" = "Execute";
              command = "noctalia msg volume-mute";
            };
          }
        ];
      };
    };
  };
}
