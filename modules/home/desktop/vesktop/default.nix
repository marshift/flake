{ config, lib, pkgs, ... }:

lib.habitat.mkModule {
  inherit config;
  path = [ "home" "desktop" "vesktop" ];
  output = {
    home.packages = [ pkgs.vesktop ];
  };
}
