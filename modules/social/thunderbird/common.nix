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
  options.swamp.social.thunderbird.enable = self.lib.options.mkEnableOptionWithDefault "Thunderbird" (
    config.swamp.social.enable && config.swamp.desktop.enable && !(isLinux && isAarch) # TODO: Remove when nixpkgs aarch64-linux Thunderbird builds are fixed
  );
}
