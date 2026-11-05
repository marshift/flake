{
  self,
  config,
  ...
}:
{
  options.swamp.media.obs.enable = self.lib.options.mkEnableOptionWithDefault "OBS Studio" (
    config.swamp.media.enable && config.swamp.desktop.enable
  );
}
