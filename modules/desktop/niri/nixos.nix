{
  inputs,
  lib,
  pkgs,
  config,
  ...
}:
let
  inherit (inputs.niri-flake) nixosModules packages;
in
{
  imports = [
    nixosModules.niri
  ];

  config = lib.modules.mkIf config.swamp.desktop.niri.enable {
    programs.niri = {
      enable = true;
      package = packages.${pkgs.stdenv.hostPlatform.system}.niri-unstable;
    };
  };
}
