{
  self,
  lib,
  pkgs,
  config,
  ...
}:
{
  options.swamp.gaming.vr.unity.enable =
    self.lib.options.mkEnableOptionWithDefault "Avatar and world creation tools (ALCOM and Unity)"
      (config.swamp.gaming.vr.enable && config.swamp.development.enable);

  config.assertions = lib.modules.mkIf config.swamp.gaming.vr.unity.enable [
    (self.lib.modules.assertIsLinux pkgs)
  ];
}
