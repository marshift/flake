{
  self,
  lib,
  pkgs,
  config,
  ...
}:
{
  options.swamp.desktop.labwc.enable = self.lib.options.mkEnableOptionWithDefault "labwc" (
    config.swamp.desktop.enable && pkgs.stdenv.hostPlatform.isLinux
  );

  config.assertions = lib.modules.mkIf config.swamp.desktop.labwc.enable [
    (self.lib.modules.assertIsLinux pkgs)
  ];
}
