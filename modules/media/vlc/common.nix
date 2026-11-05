{
  self,
  config,
  ...
}:
{
  options.swamp.media.vlc.enable = self.lib.options.mkEnableOptionWithDefault "VLC media player" (
    config.swamp.media.enable && config.swamp.desktop.enable
  );
}
