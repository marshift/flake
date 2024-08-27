{ config, lib, pkgs, ... }:

lib.habitat.mkModule {
  inherit config;
  path = [ "home" "services" "xwayland-satellite" ];
  extraOptions = {
    targetService = lib.mkOption { type = lib.types.str; };
  };
  output = with config.habitat.home.services.xwayland-satellite; {
    systemd.user.services.xwayland-satellite = lib.habitat.mkGraphicalService {
      inherit targetService;
      description = "xwayland-satellite";
      execStart = lib.getExe pkgs.xwayland-satellite;
    };
  };
}
