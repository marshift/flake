{
  lib,
  pkgs,
  osConfig,
  ...
}:
lib.modules.mkIf (osConfig.swamp.media.vlc.enable && pkgs.stdenv.hostPlatform.isLinux) {
  home.packages = [ pkgs.vlc ];
}
