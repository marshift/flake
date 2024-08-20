{ ... }:
{

  # Allow home-manager to manage itself
  programs.home-manager.enable = true;

  # Same as system.stateVersion - don't touch!
  home.stateVersion = "24.05";
}
