{
  self,
  lib,
  pkgs,
  config,
  ...
}:
{
  options.swamp.development.unity.enable =
    self.lib.options.mkEnableOptionWithDefault "Avatar and world creation tools (Unity and ALCOM)"
      (config.swamp.development.enable && config.swamp.gaming.vr.enable);

  config.assertions = lib.modules.mkIf config.swamp.development.unity.enable [
    (self.lib.modules.assertIsLinux pkgs)
  ];
}
