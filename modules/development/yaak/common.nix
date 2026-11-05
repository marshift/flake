{
  self,
  config,
  ...
}:
{
  options.swamp.development.yaak.enable = self.lib.options.mkEnableOptionWithDefault "Yaak" (
    config.swamp.development.enable && config.swamp.desktop.enable
  );
}
