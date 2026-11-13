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

  displays =
    state:
    if osConfig.programs.niri.enable then
      "${getExe programsCfg.niri.package} msg action power-${state}-monitors"
    else
      ""; # This is kinda nasty, but I don't want to make any assumptions about window manager... It'll do.

  lock = "${getExe programsCfg.swaylock.package} --daemonize";

  displaysOffAndLock = lib.strings.concatStringsSep "; " [
    (displays "off")
    lock
  ];
in
lib.modules.mkIf (osConfig.swamp.desktop.swaylock.enable && pkgs.stdenv.hostPlatform.isLinux) {
  programs.swaylock.enable = true;

  services.swayidle = {
    enable = true;
    timeouts = [
      {
        timeout = 180;
        command = displays "off";
        resumeCommand = displays "on";
      }
      {
        timeout = 300;
        command = lock;
      }
      {
        timeout = 3600;
        command = "${getExe' pkgs.systemd "systemctl"} suspend";
      }
    ];
    events = {
      "before-sleep" = displaysOffAndLock;
      "after-resume" = displays "on";
      "lock" = displaysOffAndLock;
      "unlock" = displays "on";
    };
  };
}
