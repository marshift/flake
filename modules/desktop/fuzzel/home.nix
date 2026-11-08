{
  lib,
  pkgs,
  osConfig,
  ...
}:
lib.modules.mkIf (osConfig.swamp.desktop.fuzzel.enable && pkgs.stdenv.hostPlatform.isLinux) {
  programs.fuzzel.enable = true;
}
