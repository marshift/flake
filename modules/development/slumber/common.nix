{
  self,
  config,
  ...
}:
{
  options.swamp.development.slumber.enable = self.lib.options.mkEnableOptionWithDefault "slumber" (
    config.swamp.development.enable && config.swamp.desktop.enable
  );
}
