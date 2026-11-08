{
  self,
  lib,
  pkgs,
  config,
  ...
}:
{
  options.swamp.desktop.swayosd.enable = self.lib.options.mkEnableOptionWithDefault "SwayOSD" (
    config.swamp.desktop.enable && pkgs.stdenv.hostPlatform.isLinux
  );

  config.assertions = lib.modules.mkIf config.swamp.desktop.swayosd.enable [
    (self.lib.modules.assertIsLinux pkgs)
  ];
}
