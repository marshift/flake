{
  self,
  lib,
  pkgs,
  config,
  ...
}:
{
  options.swamp.desktop.waybar.enable = self.lib.options.mkEnableOptionWithDefault "Waybar" (
    config.swamp.desktop.enable && pkgs.stdenv.hostPlatform.isLinux
  );

  config.assertions = lib.modules.mkIf config.swamp.desktop.waybar.enable [
    (self.lib.modules.assertIsLinux pkgs)
  ];
}
