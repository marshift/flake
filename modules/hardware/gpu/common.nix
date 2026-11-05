{
  self,
  lib,
  pkgs,
  config,
  ...
}:
{
  options.swamp.hardware.gpu.enable = lib.options.mkEnableOption "accelerated graphics";

  config.assertions = lib.modules.mkIf config.swamp.hardware.gpu.enable [
    (self.lib.modules.assertIsLinux pkgs)
  ];
}
