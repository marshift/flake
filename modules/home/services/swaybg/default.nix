{ config, lib, pkgs, ... }:

lib.habitat.mkModule {
  inherit config;
  path = [ "home" "services" "swaybg" ];
  extraOptions = {
    targetService = lib.mkOption { type = lib.types.str; };
  };
  output = with config.habitat.home.services.swaybg; {
    systemd.user.services.swaybg = {
      Unit = {
        Description = "swaybg";
        PartOf = [ "graphical-session.target" ];
        Requires = [ targetService ];
        After = [ targetService ];
      };
      Service = {
        ExecStart = "${lib.getExe pkgs.swaybg} -i ${config.stylix.image}";
        Restart = "on-failure";
      };
      Install = {
        WantedBy = [ targetService ];
      };
    };  
  };
}
