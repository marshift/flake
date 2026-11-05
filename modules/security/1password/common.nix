# TODO: 1Password CLI?
{
  self,
  lib,
  config,
  ...
}:
{
  options.swamp.security._1password = {
    enable = lib.options.mkEnableOption "1Password";
    sshAgent = self.lib.options.mkEnableOptionWithDefault "the 1Password SSH agent" config.swamp.security._1password.enable;
  };
}
