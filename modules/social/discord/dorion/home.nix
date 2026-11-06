{
  lib,
  pkgs,
  osConfig,
  ...
}:
lib.modules.mkIf (osConfig.swamp.social.dorion.enable && pkgs.stdenv.hostPlatform.isLinux) {
  home.packages = [ pkgs.dorion ];
}
