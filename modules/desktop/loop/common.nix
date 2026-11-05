{
  self,
  lib,
  pkgs,
  config,
  ...
}:
{
  options.swamp.desktop.loop.enable = self.lib.options.mkEnableOptionWithDefault "Loop" (
    config.swamp.desktop.enable && pkgs.stdenv.hostPlatform.isDarwin
  );

  config.assertions = lib.modules.mkIf config.swamp.desktop.loop.enable [
    (self.lib.modules.assertIsDarwin pkgs)
  ];
}
