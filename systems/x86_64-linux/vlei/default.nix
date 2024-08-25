{ inputs, ... }:

{
  imports = with inputs.nixos-hardware.nixosModules; [
    ./disks.nix
    common-pc
    common-pc-ssd
    common-cpu-amd
  ];

  boot = {
    initrd = {
      availableKernelModules = [
        "nvme"
        "xhci_pci"
        "ahci"
        "usbhid"
        "usb_storage"
        "sd_mod"
      ];
    };

    kernelModules = [ "kvm-amd" ];
  };

  habitat = {
    systemd-boot.enable = true;
    meta.drivers.nvidia.enable = true;
  };

  system.stateVersion = "24.05";
}
