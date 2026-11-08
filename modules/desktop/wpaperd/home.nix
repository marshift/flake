{
  lib,
  pkgs,
  osConfig,
  ...
}:
lib.modules.mkIf (osConfig.swamp.desktop.wpaperd.enable && pkgs.stdenv.hostPlatform.isLinux) {
  services.wpaperd.enable = true;
}
