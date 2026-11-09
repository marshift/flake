{
  self,
  lib,
  pkgs,
  config,
  ...
}:
{
  options.swamp.desktop.swaybg.enable = self.lib.options.mkEnableOptionWithDefault "swaybg" (
    config.swamp.desktop.enable && pkgs.stdenv.hostPlatform.isLinux
  );

  config.assertions = lib.modules.mkIf config.swamp.desktop.swaybg.enable [
    (self.lib.modules.assertIsLinux pkgs)
  ];
}
