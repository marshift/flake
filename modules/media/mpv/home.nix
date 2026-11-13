{
  lib,
  pkgs,
  osConfig,
  ...
}:
let
  inherit (lib.modules) mkIf;
in
mkIf osConfig.swamp.media.mpv.enable {
  programs.mpv = {
    package = mkIf pkgs.stdenv.hostPlatform.isDarwin null;
    enable = true;
  };
}
