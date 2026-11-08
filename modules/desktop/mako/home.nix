{
  lib,
  pkgs,
  osConfig,
  ...
}:
lib.modules.mkIf (osConfig.swamp.desktop.mako.enable && pkgs.stdenv.hostPlatform.isLinux) {
  services.mako.enable = true;
}
