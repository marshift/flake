{
  self,
  lib,
  pkgs,
  config,
  ...
}:
{
  options.swamp.hardware.audio.enable =
    self.lib.options.mkEnableOptionWithDefault "hearing stuff, lol" pkgs.stdenv.hostPlatform.isLinux;

  config.assertions = lib.modules.mkIf config.swamp.hardware.audio.enable [
    (self.lib.modules.assertIsLinux pkgs)
  ];
}
