{
  self,
  lib,
  pkgs,
  config,
  ...
}:
{
  options.swamp.security.little-snitch = {
    enable = self.lib.options.mkEnableOptionWithDefault "Little Snitch" pkgs.stdenv.hostPlatform.isDarwin;
    appStore.enable = lib.options.mkEnableOption "support for the Mac App Store (at the cost of more telemetry)";
  };

  config.assertions = lib.modules.mkIf config.swamp.security.little-snitch.enable [
    (self.lib.modules.assertIsDarwin pkgs)
  ];
}
