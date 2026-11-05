{
  inputs,
  lib,
  config,
  ...
}:
let
  inherit (lib.options) mkOption;
  inherit (lib.types) listOf str;
in
{
  options.swamp.secrets.sshKeyPaths = mkOption {
    type = listOf str;
    description = "The paths of the SSH keys used for sops secrets.";
  };

  config = {
    home-manager.sharedModules = [ inputs.sops-nix.homeManagerModules.sops ];
    sops.age = { inherit (config.swamp.secrets) sshKeyPaths; };
  };
}
