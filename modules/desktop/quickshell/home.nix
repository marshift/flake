{
  lib,
  pkgs,
  osConfig,
  ...
}:
lib.modules.mkIf (osConfig.swamp.desktop.quickshell.enable && pkgs.stdenv.hostPlatform.isLinux) {
  programs.quickshell = {
    enable = true;
    systemd.enable = true;

    configs = {
      "marshell" = ./marshell;
    };
    activeConfig = "marshell";
  };
}
