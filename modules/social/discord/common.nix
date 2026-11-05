{
  self,
  config,
  ...
}:
{
  options.swamp.social.discord.enable = self.lib.options.mkEnableOptionWithDefault "Discord" (
    config.swamp.social.enable && config.swamp.desktop.enable
  );
}
