{
  pkgs,
  ...
}: {
  environment.systemPackages = [ pkgs.gitMinimal ]; # Flakes need git, so put it here even if unconfigured

  nixpkgs.config.allowUnfree = true;
  nix = {
    package = pkgs.lixPackageSets.stable.lix; # Make the configuration delicious
    settings = {
      extra-substituters = [ "https://nixos-apple-silicon.cachix.org" ];
      extra-trusted-public-keys = [ "nixos-apple-silicon.cachix.org-1:8psDu5SA5dAD7qA0zMy5UT292TxeEPzIz8VVEr2Js20=" ];
      experimental-features = [ "nix-command" "flakes" ];
    };
  };
}
