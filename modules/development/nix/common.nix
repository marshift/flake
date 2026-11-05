{
  self,
  config,
  ...
}:
{
  options.swamp.development.nix.enable =
    self.lib.options.mkEnableOptionWithDefault "tools for Nix development" config.swamp.development.enable;
}
