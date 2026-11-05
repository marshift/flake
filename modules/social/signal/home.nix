{
  lib,
  pkgs,
  osConfig,
  ...
}:
lib.modules.mkIf (osConfig.swamp.social.signal.enable && pkgs.stdenv.hostPlatform.isLinux) {
  home.packages = [ pkgs.signal-desktop ];
}
