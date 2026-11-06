{
  self,
  pkgs,
  config,
  ...
}:
let
  inherit (pkgs.stdenv.hostPlatform) isLinux isAarch;
  isArmLinux = isLinux && isAarch;
in
{
  options.swamp.social.discord.enable = self.lib.options.mkEnableOptionWithDefault "Discord" (
    config.swamp.social.enable && config.swamp.desktop.enable && !isArmLinux
  );

  config.assertions = [
    {
      assertion = isArmLinux;
      message = "This module cannot be imported on ARM Linux because Discord do not build for it.";
    }
  ];
}
