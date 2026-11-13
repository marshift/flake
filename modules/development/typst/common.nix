{
  self,
  config,
  ...
}:
{
  options.swamp.development.typst.enable =
    self.lib.options.mkEnableOptionWithDefault "tools for writing documents in Typst (so like, just my CV?)" config.swamp.development.enable;
}
