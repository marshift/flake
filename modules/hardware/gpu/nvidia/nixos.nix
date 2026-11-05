{
  lib,
  pkgs,
  config,
  ...
}:
lib.modules.mkIf config.swamp.hardware.gpu.nvidia.enable {
  services.xserver.videoDrivers = [ "nvidia" ];
  environment.variables.LIBVA_DRIVER_NAME = "nvidia";

  hardware = {
    nvidia = {
      branch = "bleeding_edge";
      open = true;
      nvidiaSettings = false;
    };

    graphics = {
      extraPackages = [
        pkgs.nvidia-vaapi-driver
        pkgs.monado-vulkan-layers
      ];
      extraPackages32 = [ pkgs.pkgsi686Linux.nvidia-vaapi-driver ];
    };
  };
}
