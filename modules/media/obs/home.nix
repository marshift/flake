{
  lib,
  pkgs,
  osConfig,
  ...
}:
let
  inherit (lib.modules) mkIf;
in
# You can't null out the package for OBS Studio
mkIf (osConfig.swamp.media.obs.enable && pkgs.stdenv.hostPlatform.isLinux) {
  programs.obs-studio.enable = true;
}
