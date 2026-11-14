{
  self,
  lib,
  pkgs,
  config,
  ...
}:
{
  options.swamp.desktop.wayle.enable = self.lib.options.mkEnableOptionWithDefault "Wayle" (
    config.swamp.desktop.enable && pkgs.stdenv.hostPlatform.isLinux
  );

  config.assertions = lib.modules.mkIf config.swamp.desktop.wayle.enable [
    (self.lib.modules.assertIsLinux pkgs)
  ];
}
