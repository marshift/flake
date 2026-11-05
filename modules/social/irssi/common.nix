{
  self,
  config,
  ...
}:
{
  options.swamp.social.irssi.enable =
    self.lib.options.mkEnableOptionWithDefault "irssi" config.swamp.social.enable;
}
