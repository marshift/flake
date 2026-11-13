{
  inputs,
  lib,
}:
let
  inherit (inputs) self nixpkgs nix-darwin;
  inherit (self.lib.modules) listModulesRecursive;

  mkHost = (
    {
      id ? null, # Should be set if system uses ZFS
      name,
      arch,
      class,
    }:
    let
      os =
        {
          nixos = "linux";
          darwin = "darwin";
        }
        .${class};
      system = "${arch}-${os}";
    in
    (if class == "darwin" then nix-darwin.lib.darwinSystem else nixpkgs.lib.nixosSystem) {
      inherit system;
      specialArgs = { inherit self inputs; };
      modules = [
        {
          networking.hostName = name;
          nixpkgs.hostPlatform = system;
        }
        "${self}/hosts/${name}"
        "${self}/modules/${class}.nix"
      ]
      ++ (lib.lists.optional (class == "nixos") { networking.hostId = id; })
      ++ listModulesRecursive "common.nix"
      ++ listModulesRecursive "${class}.nix";
    }
  );

  mkHosts =
    hosts:
    lib.attrsets.listToAttrs (
      map (host: {
        inherit (host) name;
        value = mkHost host;
      }) hosts
    );
in
{
  inherit mkHost mkHosts;
}
