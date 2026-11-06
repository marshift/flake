# TODO: Declarative Dorion settings?
{
  self,
  pkgs,
  config,
  ...
}:
let
  inherit (pkgs.stdenv.hostPlatform) isLinux isAarch;
in
{
  options.swamp.social.dorion.enable = self.lib.options.mkEnableOptionWithDefault "Dorion" (
    config.swamp.social.enable && config.swamp.desktop.enable && (isLinux && isAarch)
  );
}
