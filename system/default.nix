{
  imports = [
    ./nix.nix
    ./packages.nix
    ./locale.nix
    ./networking.nix
  ];

  users.users.marsh = {
    isNormalUser = true;
    name = "marsh";
    home = "/home/marsh";
    extraGroups = [ "wheel" ];
  };

  # Don't clog my boot menu please
  boot.loader = {
    systemd-boot.configurationLimit = 3;
    grub.configurationLimit = 3;
  };

  # Make more than 1/5 of the hardware work
  hardware.enableAllFirmware = true;

  # Don't touch - or at least do some reading first.
  system.stateVersion = "24.05";
}
