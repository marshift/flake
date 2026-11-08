{
  self,
  lib,
  pkgs,
  config,
  ...
}:
{
  options.swamp.desktop.niri.enable = self.lib.options.mkEnableOptionWithDefault "Niri" (
    config.swamp.desktop.enable && pkgs.stdenv.hostPlatform.isLinux
  );

  config.assertions = lib.modules.mkIf config.swamp.desktop.niri.enable [
    (self.lib.modules.assertIsLinux pkgs)
  ];
}
