{
  self,
  config,
  ...
}:
{
  options.swamp.desktop.wezterm.enable =
    self.lib.options.mkEnableOptionWithDefault "WezTerm" config.swamp.desktop.enable;
}
