{
  lib,
  pkgs,
  osConfig,
  ...
}:
let
  inherit (lib.modules) mkIf;
in
mkIf osConfig.swamp.development.rider.enable {
  home.packages = mkIf pkgs.stdenv.hostPlatform.isLinux [ pkgs.rider ];
}
