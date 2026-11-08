{
  lib,
  pkgs,
  osConfig,
  ...
}:
let
  inherit (lib.meta) getExe getExe';

  lock = getExe pkgs.swaylock;
  display = status: "${getExe pkgs.niri} msg action power-${status}-monitors"; # TODO: Don't assume Niri?
in
lib.modules.mkIf (osConfig.swamp.desktop.swayidle.enable && pkgs.stdenv.hostPlatform.isLinux) {
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
