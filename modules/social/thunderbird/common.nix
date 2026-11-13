{
  self,
  config,
  ...
}:
{
  options.swamp.social.thunderbird.enable = self.lib.options.mkEnableOptionWithDefault "Thunderbird" (
    config.swamp.social.enable && config.swamp.desktop.enable
  );
}
