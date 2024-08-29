{ config, lib, pkgs, ... }:

lib.habitat.mkModule {
  inherit config;
  path = [ "home" "services" "waybar" ];
  extraOptions = {
    targetService = lib.mkOption { type = lib.types.str; };
  };
  output = with config.habitat.home.services.waybar; {
    programs.waybar = {
      enable = true;
      settings = {
        main = {
          layer = "top";
          position = "top";
          height = 24;

          "custom/whoami" = {
            interval = "once";
            exec = pkgs.writeShellScript "waybar-whoami" ''
              echo $USER@$HOSTNAME
            '';
          };

          "image#logo" = {
            path = ../../../../assets/pinky.png;
            size = 18;
          };

          "clock" = { tooltip = false; };
          "battery" = { format = "battery {capacity}%"; };
          "temperature" = { format = "temperature {temperatureC}°C"; };
          
          modules-left = [ "image#logo" "custom/whoami" ];
          modules-center = [ "clock" ];
          modules-right = [ "temperature" "battery" ];
        };
      };
      style = with config.lib.stylix.colors.withHashtag; ''
        window#waybar {
          color: ${base05};
          background-color: ${base00};
          border-bottom: 2px solid ${base0D};
        }

        box#image {
          margin-left: 0.25rem;
          margin-right: 0.25rem;
        }
      '';
    };

    systemd.user.services.waybar = lib.habitat.mkGraphicalService {
      inherit targetService;
      description = "simple wayland bar";
      execStart = lib.getExe config.programs.waybar.package;
      execReload = "${pkgs.coreutils}/bin/kill -SIGUSR2 $MAINPID";
      killMode = "mixed";
    };
  };
}
