# TODO: Technically, a non-desktop system could support audio, so is this the right place?
{
  self,
  lib,
  pkgs,
  config,
  ...
}:
{
  options.swamp.desktop.audio.enable =
    self.lib.options.mkEnableOptionWithDefault "hearing stuff, lol"
      (config.swamp.desktop.enable && pkgs.stdenv.hostPlatform.isLinux);

  config.assertions = lib.modules.mkIf config.swamp.desktop.audio.enable [
    (self.lib.modules.assertIsLinux pkgs)
  ];
}
