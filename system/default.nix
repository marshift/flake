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

  # Don't touch - or at least do some reading first.
  system.stateVersion = "24.05";
}
