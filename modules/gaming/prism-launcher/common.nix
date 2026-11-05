{
  self,
  config,
  ...
}:
{
  options.swamp.gaming.prism-launcher.enable =
    self.lib.options.mkEnableOptionWithDefault "Prism Launcher"
      (config.swamp.gaming.enable && config.swamp.desktop.enable);
}
