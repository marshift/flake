{ config, lib, pkgs, ... }:

lib.habitat.mkModule {
  inherit config;
  path = [ "home" "desktop" "steam" ];
  output = {
    home.packages = [ pkgs.steam ];
  };
}
