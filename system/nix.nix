{ pkgs, ... }:

{
  nix = {
    settings = {
      # Enable flake-adjacent features
      experimental-features = [ "nix-command" "flakes" ];

      # Woo, "free optimisation"
      auto-optimise-store = true;

      # Uncap connections because speeeeed
      http-connections = 0;

      # Enable confirmation on remote flake configuration
      accept-flake-config = false;
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 3d";
    };
  };

  nixpkgs = {
    config = {
      allowUnfree = true; # Absolutely proprietary.
      allowBroken = false;
    };
  };
}
