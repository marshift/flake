{
  self,
  config,
  ...
}:
{
  options.swamp.development.dprint.enable =
    self.lib.options.mkEnableOptionWithDefault "dprint, to make your code look pretty" config.swamp.development.enable;
}
