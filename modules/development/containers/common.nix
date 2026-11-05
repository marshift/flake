# TODO: If I ever use NixOS on a server, this module technically isn't for development anymore :p
{
  self,
  config,
  ...
}:
{
  options.swamp.development.containers.enable =
    self.lib.options.mkEnableOptionWithDefault "containers" config.swamp.development.enable;
}
