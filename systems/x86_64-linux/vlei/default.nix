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

  habitat.nixos = {
    systemd-boot.enable = true;
    drivers.nvidia.enable = true;
    services = {
      pipewire.enable = true;
      openrgb.enable = true;
    };
  };

  system.stateVersion = "24.05";
}
