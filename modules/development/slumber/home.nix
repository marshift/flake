{
  lib,
  pkgs,
  osConfig,
  ...
}:
lib.modules.mkIf (osConfig.swamp.development.slumber.enable && pkgs.stdenv.hostPlatform.isLinux) {
  home.packages = [ pkgs.slumber ];
}
