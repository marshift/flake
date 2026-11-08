{
  self,
  config,
  ...
}:
{
  options.swamp.development.just.enable =
    self.lib.options.mkEnableOptionWithDefault "tools for writing justfiles" config.swamp.development.enable;
}
