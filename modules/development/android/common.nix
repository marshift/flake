{
  self,
  config,
  ...
}:
{
  options.swamp.development.android.enable =
    self.lib.options.mkEnableOptionWithDefault "tools for Android development" config.swamp.development.enable;
}
