{
  self,
  lib,
  pkgs,
  config,
  ...
}:
let
  inherit (pkgs.stdenv.hostPlatform) isLinux isAarch64;
  isNotAarch64Linux = !(isLinux && isAarch64);
in
{
  options.swamp.social.discord.enable = self.lib.options.mkEnableOptionWithDefault "Discord" (
    config.swamp.social.enable && config.swamp.desktop.enable && isNotAarch64Linux
  );

  config.assertions = lib.modules.mkIf config.swamp.social.discord.enable [
    {
      assertion = isNotAarch64Linux;
      message = "This module cannot be imported on ARM64 Linux because Discord do not build for it.";
    }
  ];
}
