{
  self,
  lib,
  pkgs,
  config,
  ...
}:
{
  options.swamp.desktop.quickshell.enable = lib.options.mkEnableOption "Quickshell";

  config.assertions = lib.modules.mkIf config.swamp.desktop.quickshell.enable [
    (self.lib.modules.assertIsLinux pkgs)
  ];
}
