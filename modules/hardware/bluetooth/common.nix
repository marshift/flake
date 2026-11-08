{
  self,
  lib,
  pkgs,
  config,
  ...
}:
{
  options.swamp.hardware.bluetooth.enable =
    lib.options.mkEnableOption "configuration for Bluetooth support";

  config.assertions = lib.modules.mkIf config.swamp.hardware.bluetooth.enable [
    (self.lib.modules.assertIsLinux pkgs)
  ];
}
