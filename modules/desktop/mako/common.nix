{
  self,
  lib,
  pkgs,
  config,
  ...
}:
{
  options.swamp.desktop.mako.enable = self.lib.options.mkEnableOptionWithDefault "mako" (
    config.swamp.desktop.enable && pkgs.stdenv.hostPlatform.isLinux
  );

  config.assertions = lib.modules.mkIf config.swamp.desktop.mako.enable [
    (self.lib.modules.assertIsLinux pkgs)
  ];
}
