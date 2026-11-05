{
  self,
  lib,
  pkgs,
  config,
  ...
}:
{
  options.swamp.hardware.bluetooth.enable =
    self.lib.options.mkEnableOptionWithDefault "configuration for Bluetooth support" pkgs.stdenv.hostPlatform.isLinux;

  config.assertions = lib.modules.mkIf config.swamp.hardware.bluetooth.enable [
    (self.lib.modules.assertIsLinux pkgs)
  ];
}
