{ config, lib, pkgs, ... }:

lib.habitat.mkModule {
  inherit config;
  path = [ "home" "services" "swaybg" ];
  extraOptions = {
    targetService = lib.mkOption { type = lib.types.str; };
  };
  output = with config.habitat.home.services.swaybg; {
    systemd.user.services.swaybg = lib.habitat.mkGraphicalService {
      inherit targetService;
      description = "swaybg - simple wallpaper daemon for wlroots";
      execStart = "${lib.getExe pkgs.swaybg} -i ${config.stylix.image}";
    };  
  };
}
