{
  lib,
  pkgs,
  ...
}:
{
  environment = {
    variables.NIXPKGS_CONFIG = lib.modules.mkForce ""; # nixpkgs sets this but it's kind of evil so
    systemPackages = [ pkgs.gitMinimal ]; # Flakes effectively need git, so let's just put it here
  };

  nix = {
    package = pkgs.lixPackageSets.latest.lix; # Make the configuration delicious

    gc = {
      automatic = true;
      options = "--delete-older-than 3d";
    };

    channel.enable = false;

    # https://docs.lix.systems/manual/lix/nightly/command-ref/conf-file.html
    settings = {
      # Free up to 20GiB when there is <5GiB left.
      min-free = 5 * 1024 * 1024 * 1024;
      max-free = 20 * 1024 * 1024 * 1024;
      auto-optimise-store = true;

      warn-dirty = false;

      keep-going = true;
      log-lines = 50;

      http-connections = 0; # 0 = unlimited, is this a good idea?
      http3 = true;

      use-xdg-base-directories = true;

      accept-flake-config = false; # Hello, RCE department?
      experimental-features = [
        "nix-command"
        "flakes"
      ];

      substituters = [ "https://nix-community.cachix.org" ];
      trusted-public-keys = [ "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=" ];
    };
  };

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = _: true;
    allowBroken = false;
    allowUnsupportedSystem = false;
    allowAliases = false;
  };

  assertions = [
    {
      assertion = pkgs.overlays == [ ];
      message = "Overlays are slow and confusing - use the packages directly from the input.";
    }
  ];
}
