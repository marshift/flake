{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
let
  inherit (inputs.nixos-apple-silicon) nixosModules overlays;
  inherit (lib.modules)
    mkMerge
    mkDefault
    mkIf
    mkForce
    ;

  hardwareCfg = config.swamp.hardware;
in
{
  imports = [
    nixosModules.apple-silicon-support
  ];

  config = mkMerge [
    {
      # TODO: Remove when nixos-apple-silicon defaults this to false (soon? please?)
      hardware.asahi.enable = mkDefault false;
    }
    (mkIf hardwareCfg.asahi.enable {
      hardware.asahi = {
        enable = true;

        # You can have your overlay but I don't want it
        overlay = null;
        pkgs = mkForce (
          import (pkgs.path) {
            localSystem.system = "aarch64-linux";
            overlays = [ overlays.default ];
          }
        );

        peripheralFirmwareDirectory =
          ./firmware + "/${lib.strings.replaceString "," "-" hardwareCfg.asahi.machineId}";

        setupAsahiSound = config.swamp.desktop.audio.enable;

        avd = mkIf hardwareCfg.gpu.enable {
          enable = true;
          # TODO: At the moment this seems to make all videos Green lol
          # vaapi-support = true;
        };
      };

      # TODO: Probably should be configurable but thog don't caare
      boot.extraModprobeConfig = ''
        options hid_apple iso_layout=0
      '';
    })
  ];
}
