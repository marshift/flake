{
  lib,
  pkgs,
  osConfig,
  ...
}:
let
  inherit (lib.modules) mkIf;
in
mkIf osConfig.swamp.desktop.ghostty.enable {
  programs.ghostty = {
    package = mkIf pkgs.stdenv.hostPlatform.isDarwin null;
    enable = true;
    enableZshIntegration = true;
  };
}
