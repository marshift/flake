{
  self,
  config,
  ...
}:
{
  options.swamp.desktop.ghostty.enable =
    self.lib.options.mkEnableOptionWithDefault "Ghostty" config.swamp.desktop.enable;
}
