{
  self,
  config,
  ...
}:
{
  options.swamp.development.rust.enable =
    self.lib.options.mkEnableOptionWithDefault "tools for Rust development" config.swamp.development.enable;
}
