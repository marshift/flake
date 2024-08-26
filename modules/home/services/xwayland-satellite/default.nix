{ config, lib, inputs, system, ... }:

lib.habitat.mkModule {
  inherit config;
  path = [ "home" "services" "xwayland-satellite" ];
  extraOptions = {
    targetService = lib.mkOption { type = lib.types.str; };
    execStart = lib.mkOption { type = lib.types.str; };
  };
  output = with config.habitat.home.services.xwayland-satellite; {
    systemd.user.services.xwayland-satellite = {
      Unit = {
        Description = "xwayland-satellite";
        PartOf = [ "graphical-session.target" ];
        Requires = [ targetService ];
        After = [ targetService ];
      };
      Service = {
        ExecStart = execStart;
        Restart = "on-failure";
      };
      Install = {
        WantedBy = [ targetService ];
      };
    };  
  };
}
