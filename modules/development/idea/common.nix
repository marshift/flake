{
  self,
  config,
  ...
}:
{
  options.swamp.development.idea.enable = self.lib.options.mkEnableOptionWithDefault "IntelliJ IDEA" (
    config.swamp.development.enable && config.swamp.desktop.enable
  );
}
