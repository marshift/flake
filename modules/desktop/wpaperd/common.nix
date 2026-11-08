{
  self,
  lib,
  pkgs,
  config,
  ...
}:
{
  options.swamp.desktop.wpaperd.enable = self.lib.options.mkEnableOptionWithDefault "wpaperd" (
    config.swamp.desktop.enable && pkgs.stdenv.hostPlatform.isLinux
  );

  config.assertions = lib.modules.mkIf config.swamp.desktop.wpaperd.enable [
    (self.lib.modules.assertIsLinux pkgs)
  ];
}
