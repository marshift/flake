{ inputs, ... }:

{
  imports = with inputs.nixos-hardware.nixosModules; [
    ./disks.nix
    apple-macbook-pro-12-1
  ];

  boot = {
    initrd = {
      availableKernelModules = [
        "xhci_pci"
        "ahci"
        "usb_storage"
        "usbhid"
        "sd_mod"
      ];
    };

    kernelModules = [ "kvm-intel" ];
  };

  hardware.graphics.enable = true;

  habitat.nixos = {
    systemd-boot.enable = true;
    services.pipewire.enable = true;
  };

  system.stateVersion = "24.05";
}
