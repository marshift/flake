{
  self,
  lib,
  pkgs,
  config,
  ...
}:
{
  options.swamp.gaming.vr.wivrn.enable = self.lib.options.mkEnableOptionWithDefault "WiVRn" (
    config.swamp.gaming.vr.enable && config.swamp.desktop.enable
  );

  config.assertions = lib.modules.mkIf config.swamp.gaming.vr.wivrn.enable [
    (self.lib.modules.assertIsLinux pkgs)
  ];
}
