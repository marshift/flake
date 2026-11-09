{
  lib,
  pkgs,
  osConfig,
  config,
  ...
}:
let
  inherit (lib.meta) getExe getExe';

  programsCfg = config.programs;

  lock = getExe programsCfg.swaylock.package;
  display =
    status:
    if osConfig.programs.niri.enable then
      "${getExe programsCfg.niri.package} msg action power-${status}-monitors"
    # This is kind of bad, but I don't want to make any assumptions about window manager..
    else
      "";
in
lib.modules.mkIf (osConfig.swamp.desktop.swaylock.enable && pkgs.stdenv.hostPlatform.isLinux) {
  programs.swaylock.enable = true;
  services.swayidle = {
    enable = true;

    timeouts = [
      {
        timeout = 180;
        command = display "off";
        resumeCommand = display "on";
      }
      {
        timeout = 300;
        command = lock;
      }
      {
        timeout = 1800;
        command = "${getExe' pkgs.systemd "systemctl"} suspend";
      }
    ];

    events = {
      "before-sleep" = (display "off") + "; " + lock;
      "after-resume" = display "on";
      "lock" = (display "off") + "; " + lock;
      "unlock" = display "on";
    };
  };
}
