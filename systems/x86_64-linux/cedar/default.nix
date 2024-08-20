{ pkgs, ... }:
{
  imports = [ ./hardware.nix ];

  # Setup bootloader
  boot.loader = {
    systemd-boot = {
      enable = true;
      configurationLimit = 3;
    };

    efi.canTouchEfiVariables = true;
  };

  # Make more than 1/5 of the hardware work
  hardware.enableAllFirmware = true;

  # Don't touch - or at least do some reading first.
  system.stateVersion = "24.05";
}
