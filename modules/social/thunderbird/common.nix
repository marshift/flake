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
  options.swamp.social.thunderbird.enable = self.lib.options.mkEnableOptionWithDefault "Thunderbird" (
    config.swamp.social.enable && config.swamp.desktop.enable && !(isLinux && isAarch64) # TODO: Remove when nixpkgs aarch64-linux Thunderbird builds are fixed
  );
}
