{
  self,
  config,
  ...
}:
{
  options.swamp.development.javascript.enable =
    self.lib.options.mkEnableOptionWithDefault "tools for JavaScript development" config.swamp.development.enable;
}
