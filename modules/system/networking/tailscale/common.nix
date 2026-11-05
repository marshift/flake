{
  self,
  ...
}:
{
  options.swamp.system.networking.tailscale.enable =
    self.lib.options.mkEnableOptionWithDefault "Tailscale" true;
}
