{
  inputs,
  lib,
}:
{
  systems = import ./systems.nix { inherit inputs lib; };
  hosts = import ./hosts.nix { inherit inputs lib; };
  modules = import ./modules.nix { inherit inputs lib; };
  options = import ./options.nix { inherit lib; };
  secrets = import ./secrets.nix { inherit inputs lib; };
}
