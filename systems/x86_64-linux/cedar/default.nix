{ inputs, ... }:

{
  imports = with inputs.nixos-hardware.nixosModules; [
    ./disks.nix
    ./boot.nix
    apple-macbook-pro-12-1
  ];

  # Make more than 1/5 of the hardware work
  hardware.enableAllFirmware = true;

  # Don't touch - or at least do some reading first.
  system.stateVersion = "24.05";
}
