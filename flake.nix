{
  description = "marsh's Nix/OS|-darwin/ configurations";

  inputs = {
    # It's just generally better to use a non-GitHub URL for nixpkgs these days.
    nixpkgs.url = "https://channels.nixos.org/nixpkgs-unstable/nixexprs.tar.zst";
    nixpkgs-xr = {
      url = "github:nix-community/nixpkgs-xr/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-apple-silicon = {
      url = "github:nix-community/nixos-apple-silicon/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-homebrew.url = "github:zhaofengli/nix-homebrew/main";
    homebrew-core = {
      url = "github:homebrew/homebrew-core/main";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask/main";
      flake = false;
    };
    homebrew-dorion = {
      url = "https://github.com/psharma04/homebrew-dorion";
      flake = false;
    };

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    moonlight = {
      url = "github:moonlight-mod/moonlight/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    steam-config-nix = {
      url = "github:different-name/steam-config-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      ...
    }:
    let
      inherit (self.lib.systems) forAllSystems;
      inherit (self.lib.hosts) mkHosts;
    in
    {
      lib = import ./lib {
        inherit inputs;
        inherit (nixpkgs) lib;
      };

      formatter = forAllSystems (pkgs: pkgs.nixfmt-tree);

      packages = forAllSystems (pkgs: {
        helium = pkgs.callPackage ./packages/helium { };
      });

      devShells = forAllSystems (pkgs: {
        default = pkgs.mkShell {
          packages = with pkgs; [
            gitMinimal
            just
            sops
            nano
          ];
        };
      });

      nixosConfigurations = mkHosts [
        {
          id = "891d3295";
          name = "dark";
          arch = "x86_64";
          class = "nixos";
        }
        {
          id = "80649a80";
          name = "susie";
          arch = "aarch64";
          class = "nixos";
        }
      ];
      darwinConfigurations = mkHosts [ ];
    };
}
