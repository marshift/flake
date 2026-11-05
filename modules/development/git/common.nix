{
  self,
  config,
  ...
}:
{
  options.swamp.development.git.enable =
    self.lib.options.mkEnableOptionWithDefault "Git" config.swamp.development.enable;
}
