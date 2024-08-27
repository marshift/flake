{ config, lib, pkgs, ... }:

lib.habitat.mkModule {
  inherit config;
  path = [ "home" "desktop" "firefox" ];
  output = {
    programs.firefox = {
      enable = true;
      package = pkgs.firefox-beta;
    };
  };
}
