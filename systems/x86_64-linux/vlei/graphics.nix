# Loosely based on the nixos-hardware NVIDIA derivation
{ config, lib, pkgs, ... }:

let
  vaPackages = with pkgs; [
    nvidia-vaapi-driver
    libvdpau-va-gl
  ];
in
{
  hardware = {
    # NVIDIA driver options
    nvidia = {
      modesetting.enable = true;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.beta;
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
}
