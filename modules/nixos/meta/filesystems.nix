{
  lib,
  ...
}: {
  fileSystems = {
    "/" = {
      device = lib.mkDefault "/dev/disk/by-label/NIXOS_ROOT";
      fsType = "ext4";
    };
    "/boot" = {
      device = lib.mkDefault "/dev/disk/by-label/NIXOS_BOOT";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };
  };

  swapDevices = lib.mkDefault [ { device = "/dev/disk/by-label/NIXOS_SWAP"; } ];
}
