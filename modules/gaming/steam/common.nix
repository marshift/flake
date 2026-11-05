{
  self,
  lib,
  pkgs,
  config,
  ...
}:
{
  options.swamp.gaming.steam.enable = self.lib.options.mkEnableOptionWithDefault "Steam" (
    config.swamp.gaming.enable && config.swamp.desktop.enable && pkgs.stdenv.hostPlatform.isLinux
  );

  config.assertions = lib.modules.mkIf config.swamp.gaming.steam.enable [
    (self.lib.modules.assertIsLinux pkgs)
  ];
}
