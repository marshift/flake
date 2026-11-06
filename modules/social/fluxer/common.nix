{
  self,
  config,
  ...
}:
{
  options.swamp.social.fluxer.enable = self.lib.options.mkEnableOptionWithDefault "Fluxer" (
    config.swamp.social.enable && config.swamp.desktop.enable
  );
}
