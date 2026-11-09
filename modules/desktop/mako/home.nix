{
  lib,
  pkgs,
  osConfig,
  ...
}:
lib.modules.mkIf (osConfig.swamp.desktop.mako.enable && pkgs.stdenv.hostPlatform.isLinux) {
  services.mako = {
    enable = true;
    settings = {
      default-timeout = 1000;
      ignore-timeout = true;
    };
  };
}
