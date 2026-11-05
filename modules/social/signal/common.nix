{
  self,
  config,
  ...
}:
{
  options.swamp.social.signal.enable = self.lib.options.mkEnableOptionWithDefault "Signal Desktop" (
    config.swamp.social.enable && config.swamp.desktop.enable
  );
}
