# TODO: Declarative Dorion settings?
{
  self,
  pkgs,
  config,
  ...
}:
let
  inherit (pkgs.stdenv.hostPlatform) isLinux isAarch64;
in
{
  options.swamp.social.dorion.enable = self.lib.options.mkEnableOptionWithDefault "Dorion" (
    config.swamp.social.enable && config.swamp.desktop.enable && (isLinux && isAarch64) && false # TODO: Remove when Dorion builds are fixed... again. Please merge Dorion 7.0.x into nixpkgs already. I'm so tired of WebKitGTK.
  );
}
