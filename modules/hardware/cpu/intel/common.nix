{
  self,
  lib,
  pkgs,
  config,
  ...
}:
{
  options.swamp.hardware.cpu.intel.enable =
    lib.options.mkEnableOption "configuration for an Intel CPU";

  config.assertions = lib.modules.mkIf config.swamp.hardware.cpu.intel.enable [
    (self.lib.modules.assertIsLinux pkgs)
  ];
}
