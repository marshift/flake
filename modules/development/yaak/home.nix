{
  lib,
  pkgs,
  osConfig,
  ...
}:
lib.modules.mkIf (osConfig.swamp.development.yaak.enable && pkgs.stdenv.hostPlatform.isLinux) {
  home.packages = [ pkgs.yaak ];
}
