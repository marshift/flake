{
  self,
  config,
  ...
}:
{
  options.swamp.media.mpv.enable = self.lib.options.mkEnableOptionWithDefault "mpv" (
    config.swamp.media.enable && config.swamp.desktop.enable
  );
}
