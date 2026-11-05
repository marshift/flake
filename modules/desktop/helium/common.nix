{
  self,
  config,
  ...
}:
{
  options.swamp.desktop.helium.enable =
    self.lib.options.mkEnableOptionWithDefault "Helium Browser" config.swamp.desktop.enable;
}
