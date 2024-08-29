# Loosely based on the nixos-hardware NVIDIA derivation
{ config, lib, pkgs, ... }:

let
  vaPackages = with pkgs; [ nvidia-vaapi-driver ];
  driverPackage = config.boot.kernelPackages.nvidiaPackages.beta;
in
lib.habitat.mkModule {
  inherit config;
  path = [ "nixos" "drivers" "nvidia" ];
  output = {
    hardware = {
      # NVIDIA driver options
      nvidia = {
        package = driverPackage;
        forceFullCompositionPipeline = true;
        modesetting.enable = true;
        nvidiaSettings = true;
      };

      # Video acceleration
      graphics = {
        enable = true;
        extraPackages = vaPackages;
        extraPackages32 = vaPackages;
      };
    };

    # Tell X11 and Wayland to use the NVIDIA driver
    services.xserver.videoDrivers = [ "nvidia" ];
  };
}
