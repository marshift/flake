{
  lib,
  pkgs,
  osConfig,
  config,
  ...
}:
lib.modules.mkIf (osConfig.swamp.desktop.swaybg.enable && pkgs.stdenv.hostPlatform.isLinux) {
  systemd.user.services.swaybg = {
    Unit = {
      Description = "Wallpaper daemon";
      PartOf = [ config.wayland.systemd.target ];
      After = [ config.wayland.systemd.target ];
      ConditionEnvironment = "WAYLAND_DISPLAY";
    };

    Service = {
      Type = "simple";
      ExecStart = "${lib.meta.getExe pkgs.swaybg} -i ${config.stylix.image}";
      Restart = "always";
    };

    Install.WantedBy = [ config.wayland.systemd.target ];
  };
}
