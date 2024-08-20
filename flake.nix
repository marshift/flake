{
  description = "marsh's lovely little nix flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-24.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lix = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.91.0.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    snowfall-lib = {
      type = "github";
      owner = "snowfallorg";
      repo = "lib";
      ref = "dev";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    inputs:
    let
      lib = inputs.snowfall-lib.mkLib {
        inherit inputs;
        src = ./.;
        snowfall = {
          namespace = "marsh";
        };
      };
    in
    lib.mkFlake {
      channels-config = {
        allowUnfree = true;
      };
      overlays = with inputs; [ lix.overlays.default ];
      systems.modules.nixos = with inputs; [ ];
      homes.modules = with inputs; [ ];
      outputs-builder = channels: { formatter = channels.nixpkgs.nixfmt-rfc-style; };
    };

}
