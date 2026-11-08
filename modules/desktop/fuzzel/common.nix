{
  self,
  lib,
  pkgs,
  config,
  ...
}:
{
  options.swamp.desktop.fuzzel.enable = self.lib.options.mkEnableOptionWithDefault "Fuzzel" (
    config.swamp.desktop.enable && pkgs.stdenv.hostPlatform.isLinux
  );

  config.assertions = lib.modules.mkIf config.swamp.desktop.fuzzel.enable [
    (self.lib.modules.assertIsLinux pkgs)
  ];
}
