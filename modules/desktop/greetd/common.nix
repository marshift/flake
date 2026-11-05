{
  self,
  lib,
  pkgs,
  config,
  ...
}:
{
  options.swamp.desktop.greetd.enable = self.lib.options.mkEnableOptionWithDefault "greetd" (
    config.swamp.desktop.enable && pkgs.stdenv.hostPlatform.isLinux
  );

  config.assertions = lib.modules.mkIf config.swamp.desktop.greetd.enable [
    (self.lib.modules.assertIsLinux pkgs)
  ];
}
