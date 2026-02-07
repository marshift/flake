{ config, lib, pkgs, ... }:

{
  boot = {
    initrd = {
      availableKernelModules = [ "usb_storage" ];
      kernelModules = [ "dm-snapshot" "cryptd" ];
      luks.devices."cryptroot".device = "/dev/disk/by-label/NIXOS_LUKS";
    };
    kernelModules = [ ];
    extraModulePackages = [ ];
    extraModprobeConfig = ''
      options hid_apple iso_layout=0
    '';

    loader = {
      efi.canTouchEfiVariables = false; # Please don't break my macOS install.
      systemd-boot.enable = true;
    };
  };
}
