# TODO: Bitwarden CLI?
{
  self,
  config,
  ...
}:
let
  inherit (self.lib.options) mkEnableOptionWithDefault;
in
{
  options.swamp.security.bitwarden = {
    enable = mkEnableOptionWithDefault "Bitwarden" config.swamp.desktop.enable;
    sshAgent = mkEnableOptionWithDefault "the Bitwarden SSH agent" config.swamp.security.bitwarden.enable;
  };
}
