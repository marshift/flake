{
  imports = [
    ./nix.nix
    ./packages.nix
    ./locale.nix
  ];

  users.users.marsh = {
    isNormalUser = true;
    name = "marsh";
    home = "/home/marsh";
    extraGroups = [ "wheel" ];
  };

  # TODO: Can I put this anywhere more fitting?
  networking.networkmanager.enable = true;

  # Don't touch - or at least do some reading first.
  system.stateVersion = "24.05";
}
