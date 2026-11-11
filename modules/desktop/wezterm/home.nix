{
  lib,
  pkgs,
  osConfig,
  ...
}:
let
  inherit (lib.modules) mkIf;
in
mkIf osConfig.swamp.desktop.wezterm.enable {
  programs.wezterm = {
    package = mkIf pkgs.stdenv.hostPlatform.isDarwin null;
    enable = true;
    enableZshIntegration = true;
  };
}
