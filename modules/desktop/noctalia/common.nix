# TODO: DESTROY!
{
  self,
  lib,
  pkgs,
  config,
  ...
}:
{
  options.swamp.desktop.noctalia.enable =
    self.lib.options.mkEnableOptionWithDefault "Noctalia Shell"
      (config.swamp.desktop.enable && pkgs.stdenv.hostPlatform.isLinux);

  config.assertions = lib.modules.mkIf config.swamp.desktop.noctalia.enable [
    (self.lib.modules.assertIsLinux pkgs)
  ];
}
