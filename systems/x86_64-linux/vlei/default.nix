{ inputs, ... }:

{
  imports = with inputs.nixos-hardware.nixosModules; [
    ./disks.nix
    ./boot.nix
    ./graphics.nix
    common-pc
    common-pc-ssd
    common-cpu-amd
  ];

  # Make more than 1/5 of the hardware work
  hardware.enableAllFirmware = true;

  # Don't touch - or at least do some reading first.
  system.stateVersion = "24.05";
}
