{
  description = "marsh's NixOS configurations";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixos-apple-silicon = {
      url = "github:nix-community/nixos-apple-silicon/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, ... }@attrs: {
    nixosConfigurations.sally = nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";
      specialArgs = attrs;
      modules = [ ./systems/sally/configuration.nix ];
    };
  };
}
