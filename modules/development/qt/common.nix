{
  self,
  config,
  ...
}:
{
  options.swamp.development.qt.enable =
    self.lib.options.mkEnableOptionWithDefault "tools for Qt development" config.swamp.development.enable;
}
