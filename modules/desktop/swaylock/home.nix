{
  lib,
  pkgs,
  osConfig,
  ...
}:
lib.modules.mkIf (osConfig.swamp.desktop.swaylock.enable && pkgs.stdenv.hostPlatform.isLinux) {
  programs.swaylock.enable = true;
}
