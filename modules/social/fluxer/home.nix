{
  inputs,
  lib,
  pkgs,
  osConfig,
  ...
}:
let
  inherit (pkgs.stdenv.hostPlatform) isLinux system;
in
lib.modules.mkIf (osConfig.swamp.social.fluxer.enable && isLinux) {
  home.packages = [ inputs.fluxer-flake.packages.${system}.fluxer-canary ];
}
