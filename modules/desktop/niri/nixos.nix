{
  inputs,
  lib,
  pkgs,
  config,
  ...
}:
let
  inherit (inputs) niri;
in
{
  imports = [
    niri.nixosModules.niri
  ];

  config = lib.modules.mkIf config.swamp.desktop.niri.enable {
    programs.niri = {
      enable = true;
      package = pkgs.niri; # TODO: niri-unstable doesn't seem to work
    };
  };
}
