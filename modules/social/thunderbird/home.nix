{
  lib,
  pkgs,
  osConfig,
  ...
}:
let
  inherit (lib.modules) mkIf;
in
# You can't null out the package for Thunderbird
mkIf (osConfig.swamp.social.thunderbird.enable && pkgs.stdenv.hostPlatform.isLinux) {
  programs.thunderbird.enable = true;
}
