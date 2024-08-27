{ config, lib, ... }:

lib.habitat.mkModule {
  inherit config;
  path = [ "home" "desktop" "fuzzel" ];
  output = {
    programs.fuzzel = {
      enable = true;
    };
  };
}
