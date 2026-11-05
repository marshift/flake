{
  self,
  lib,
  pkgs,
  config,
  ...
}:
{
  options.swamp.security.firejail.enable =
    self.lib.options.mkEnableOptionWithDefault "Firejail" pkgs.stdenv.hostPlatform.isLinux;

  config.assertions = lib.modules.mkIf config.swamp.security.firejail.enable [
    (self.lib.modules.assertIsLinux pkgs)
  ];
}
