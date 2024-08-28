{ config, lib, pkgs, ... }:

lib.habitat.mkModule {
  inherit config;
  path = [ "nixos" "xdg" ];
  default = true;
  output = {
    environment.systemPackages = [ pkgs.xdg-utils ];
    xdg = {
      autostart.enable = true;
      menus.enable = true;
      mime.enable = true;
      icons.enable = true;
    };
  };
}
