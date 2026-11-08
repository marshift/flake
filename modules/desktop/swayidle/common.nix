{
  self,
  lib,
  pkgs,
  config,
  ...
}:
{
  options.swamp.desktop.swayidle.enable = self.lib.options.mkEnableOptionWithDefault "swayidle" (
    config.swamp.desktop.enable && pkgs.stdenv.hostPlatform.isLinux
  );

  config.assertions = lib.modules.mkIf config.swamp.desktop.swayidle.enable [
    (self.lib.modules.assertIsLinux pkgs)
  ];
}
