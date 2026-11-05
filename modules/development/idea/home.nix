{
  lib,
  pkgs,
  osConfig,
  ...
}:
lib.modules.mkIf (osConfig.swamp.development.idea.enable && pkgs.stdenv.hostPlatform.isLinux) {
  home.packages = [ pkgs.intellij-idea ];
}
