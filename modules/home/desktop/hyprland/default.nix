{ config, lib, pkgs, ... }:

lib.habitat.mkModule {
  inherit config;
  path = [ "home" "desktop" "hyprland" ];
  output = {
    wayland.windowManager.hyprland = {
      enable = true;
      systemd.enable = true;
      settings = {
        "$mod" = "SUPER";
        bind = [ "$mod, Return, exec, ${lib.getExe pkgs.foot}" ];
      };
    };
  };
}
