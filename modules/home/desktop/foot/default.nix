{ config, lib, ... }:

lib.habitat.mkModule {
  inherit config;
  path = [ "home" "desktop" "foot" ];
  output = {
    programs.foot = {
      enable = true;
      settings.main.term = "xterm-256color";
    };
  };
}
