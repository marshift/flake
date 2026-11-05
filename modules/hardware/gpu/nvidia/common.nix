{
  self,
  lib,
  pkgs,
  config,
  ...
}:
{
  options.swamp.hardware.gpu.nvidia.enable =
    lib.options.mkEnableOption "configuration for a NVIDIA GPU";

  config.assertions = lib.modules.mkIf config.swamp.hardware.gpu.nvidia.enable [
    (self.lib.modules.assertIsLinux pkgs)
  ];
}
