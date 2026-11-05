{
  self,
  lib,
  pkgs,
  config,
  ...
}:
{
  options.swamp.gaming.vr.vrchat.enable =
    self.lib.options.mkEnableOptionWithDefault "VRChat (installed from Steam)"
      (config.swamp.gaming.vr.enable && config.swamp.desktop.enable);

  config.assertions = lib.modules.mkIf config.swamp.gaming.vr.vrchat.enable [
    (self.lib.modules.assertIsLinux pkgs)
  ];
}
