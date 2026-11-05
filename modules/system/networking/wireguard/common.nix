{
  self,
  ...
}:
{
  options.swamp.system.networking.wireguard.enable =
    self.lib.options.mkEnableOptionWithDefault "WireGuard" true;
}
