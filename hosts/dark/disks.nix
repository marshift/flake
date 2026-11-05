{
  boot = {
    initrd = {
      availableKernelModules = [
        "nvme"
        "xhci_pci"
        "ahci"
        "usbhid"
        "uas"
        "sd_mod"
      ];
      luks.devices = {
        crypt.device = "/dev/disk/by-uuid/8aa23ad1-3d75-4d01-ab3c-b5f70eb4a269";
        datacrypt.device = "/dev/disk/by-uuid/4f90ca87-7196-4640-b6ec-97178ac0b33c";
      };
    };
    supportedFilesystems = [ "zfs" ];
    zfs.extraPools = [ "datapool" ];
  };

  fileSystems = {
    "/" = {
      device = "rpool/root/nixos";
      fsType = "zfs";
    };

    "/home" = {
      device = "rpool/home";
      fsType = "zfs";
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/1E75-C548";
      fsType = "vfat";
      options = [
        "fmask=0022"
        "dmask=0022"
      ];
    };

    "/mnt/data" = {
      device = "datapool/data";
      fsType = "zfs";
    };
  };

  swapDevices = [
    { device = "/dev/disk/by-uuid/edd27163-294a-4e11-9498-eb693a72b724"; }
  ];
}
