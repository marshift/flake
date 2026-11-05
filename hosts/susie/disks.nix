{
  boot = {
    initrd = {
      availableKernelModules = [ "usb_storage" ];
      luks.devices.crypt.device = "/dev/disk/by-uuid/365b4f76-8d26-4650-bd6e-4099811b1fa6";
    };
    supportedFilesystems = [ "btrfs" ];
  };

  fileSystems = {
    "/" = {
      device = "/dev/mapper/crypt";
      fsType = "btrfs";
      options = [
        "subvol=@root"
        "compress=zstd"
        "noatime"
      ];
    };

    "/home" = {
      device = "/dev/mapper/crypt";
      fsType = "btrfs";
      options = [
        "subvol=@home"
        "compress=zstd"
        "noatime"
      ];
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/B663-1CFE";
      fsType = "vfat";
      options = [
        "fmask=0022"
        "dmask=0022"
      ];
    };
  };

  swapDevices = [
    { device = "/dev/disk/by-uuid/3d7f563e-e268-4605-8970-bba63ed4849b"; }
  ];
}
