{
  lib,
  pkgs,
  osConfig,
  ...
}:
let
  wallpaperCfg = osConfig.swamp.desktop.wallpapers;

  activeWallpaperPoolDirectories = map (name: wallpaperCfg.pools.${name}) wallpaperCfg.activePools;

  wallpapersDirectory = pkgs.symlinkJoin {
    name = "marshflake-wallpapers";
    paths = activeWallpaperPoolDirectories;
  };
in
lib.modules.mkIf (osConfig.swamp.desktop.labwc.enable && pkgs.stdenv.hostPlatform.isLinux) {
  programs.noctalia = {
    enable = true;
    systemd.enable = true;

    settings = {
      theme = {
        mode = "dark";
        source = "builtin";
        builtin = "Gruvbox";
      };

      shell = {
        corner_radius_scale = 0;
        popup_shadows = false;
        clipboard_enabled = false;
        setup_wizard_enabled = false;
        show_location = false;

        panel = {
          shadow = false;
          open_near_click_control_center = true;
          open_near_click_session = true;
        };

        launcher = {
          categories = false;
          compact = true;
        };

        animation.enabled = false;
        shadow.alpha = 0.0;

        session.actions = [
          {
            action = "command";
            glyph = "lock";
            label = "Lock";
            command = "swaylock -f";
          }
          { action = "logout"; }
          {
            action = "shutdown";
            variant = "destructive";
          }
        ];
      };

      bar.default = {
        radius = 0;
        background_opacity = 0.8;
        padding = 0;
        margin_ends = 0;
        shadow = false;

        capsule = true;
        capsule_radius = 0.0;

        start = [ "launcher" ];
        center = [ ];
        end = [
          "media"
          "tray"
          "bluetooth"
          "clock"
          "session"
        ];
      };

      weather.enabled = false;
      lockscreen.enabled = false;

      osd.kinds.lock_keys = false; # My keyboard has a light for this

      notification = {
        filter_order = [ "disable_history" ];

        filter.disable_history = {
          enabled = true;
          match_content = ".*";
          show_toast = true;
          save_history = false;
          play_sound = true;
        };
      };

      control_center = {
        hidden_tabs = [
          "monitor"
          "weather"
          "calendar"
          "notifications"
          "screen-time"
          "power"
        ];
        shortcuts = [ ];
      };

      wallpaper = {
        enabled = wallpaperCfg.enable;
        directory = wallpapersDirectory;

        automation = {
          enabled = true;
          interval_seconds = wallpaperCfg.cycleInterval;
          order = "alphabetical";
          recursive = true;
        };
      };
    };
  };
}
