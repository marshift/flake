{
  self,
  config,
  ...
}:
{
  options.swamp.development.rider.enable =
    self.lib.options.mkEnableOptionWithDefault "Jetbrains Rider"
      (config.swamp.development.enable && config.swamp.desktop.enable);
}
