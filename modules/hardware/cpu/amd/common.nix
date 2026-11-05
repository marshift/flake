{
  self,
  lib,
  pkgs,
  config,
  ...
}:
{
  options.swamp.hardware.cpu.amd.enable = lib.options.mkEnableOption "configuration for an AMD CPU";

  config.assertions = lib.modules.mkIf config.swamp.hardware.cpu.amd.enable [
    (self.lib.modules.assertIsLinux pkgs)
  ];
}
