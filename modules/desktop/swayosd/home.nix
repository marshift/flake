{
  lib,
  pkgs,
  osConfig,
  ...
}:
lib.modules.mkIf (osConfig.swamp.desktop.swayosd.enable && pkgs.stdenv.hostPlatform.isLinux) {
  services.swayosd.enable = true;
}
