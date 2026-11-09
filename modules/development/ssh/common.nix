{
  self,
  config,
  ...
}:
{
  options.swamp.development.ssh.enable =
    self.lib.options.mkEnableOptionWithDefault "SSH" config.swamp.development.enable;
}
