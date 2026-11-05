{
  self,
  lib,
  pkgs,
  config,
  ...
}:
{
  options.swamp.desktop.cursor.enable =
    self.lib.options.mkEnableOptionWithDefault "a pretty mouse cursor"
      (config.swamp.desktop.enable && pkgs.stdenv.hostPlatform.isLinux);

  config.assertions = lib.modules.mkIf config.swamp.desktop.cursor.enable [
    (self.lib.modules.assertIsLinux pkgs)
  ];
}
