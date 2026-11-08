{
  self,
  lib,
  pkgs,
  config,
  ...
}:
{
  options.swamp.desktop.swaylock.enable = self.lib.options.mkEnableOptionWithDefault "swaylock" (
    config.swamp.desktop.enable && pkgs.stdenv.hostPlatform.isLinux
  );

  config.assertions = lib.modules.mkIf config.swamp.desktop.swaylock.enable [
    (self.lib.modules.assertIsLinux pkgs)
  ];
}
