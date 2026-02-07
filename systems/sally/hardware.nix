{ config, lib, pkgs, inputs, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    inputs.nixos-apple-silicon.nixosModules.apple-silicon-support
  ];

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

  hardware.asahi.peripheralFirmwareDirectory = ./firmware;

  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
}
