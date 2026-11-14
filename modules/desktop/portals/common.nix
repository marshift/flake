{
  self,
  lib,
  pkgs,
  config,
  ...
}:
{
  options.swamp.desktop.portals.enable = self.lib.options.mkEnableOptionWithDefault "XDG portals" (
    config.swamp.desktop.enable && pkgs.stdenv.hostPlatform.isLinux
  );

  config.assertions = lib.modules.mkIf config.swamp.desktop.portals.enable [
    (self.lib.modules.assertIsLinux pkgs)
  ];
}
