{
  lib,
  pkgs,
  config,
  ...
}:
let
  inherit (lib.modules) mkIf mkForce;
in
mkIf config.swamp.hardware.gpu.enable {
  hardware.graphics = {
    enable = true;
    enable32Bit = mkForce pkgs.stdenv.hostPlatform.isx86_64;
  };

  environment.systemPackages = with pkgs; [
    vulkan-tools
    vulkan-loader
    vulkan-validation-layers
    vulkan-extension-layer

    libva
    libva-utils
  ];
}
