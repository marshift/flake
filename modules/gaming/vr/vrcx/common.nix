{
  self,
  lib,
  pkgs,
  config,
  ...
}:
{
  options.swamp.gaming.vr.vrcx.enable = self.lib.options.mkEnableOptionWithDefault "VRCX" (
    config.swamp.gaming.vr.enable && config.swamp.desktop.enable
  );

  config.assertions = lib.modules.mkIf config.swamp.gaming.vr.vrcx.enable [
    (self.lib.modules.assertIsLinux pkgs)
  ];
}
