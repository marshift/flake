# TODO: Package for NixOS?
{
  self,
  lib,
  pkgs,
  config,
  ...
}:
{
  options.swamp.development.impactor.enable = self.lib.options.mkEnableOptionWithDefault "Impactor" (
    config.swamp.development.enable && config.swamp.desktop.enable && pkgs.stdenv.hostPlatform.isDarwin
  );

  config.assertions = lib.modules.mkIf config.swamp.development.impactor.enable [
    (self.lib.modules.assertIsDarwin pkgs)
  ];
}
