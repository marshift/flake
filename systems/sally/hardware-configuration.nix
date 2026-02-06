{ config, lib, pkgs, modulesPath, nixos-apple-silicon, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    nixos-apple-silicon.nixosModules.apple-silicon-support
  ];

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

    loader.efi.canTouchEfiVariables = false; # Please don't break my macOS install.
  };

  hardware.asahi.peripheralFirmwareDirectory = ./firmware;

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXOS_ROOT";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/7D4E-1710"; # Assigned by Asahi Linux Installer
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };
  };

  swapDevices = [ { device = "/dev/disk/by-label/NIXOS_SWAP"; } ];

  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
}
