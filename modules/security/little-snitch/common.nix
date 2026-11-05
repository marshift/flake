{
  self,
  lib,
  pkgs,
  config,
  ...
}:
{
  options.swamp.security.little-snitch.enable =
    self.lib.options.mkEnableOptionWithDefault "Little Snitch" pkgs.stdenv.hostPlatform.isDarwin;

  config.assertions = lib.modules.mkIf config.swamp.security.little-snitch.enable [
    (self.lib.modules.assertIsDarwin pkgs)
  ];
}
