{
  lib,
  pkgs,
  config,
  osConfig,
  ...
}:
let
  inherit (lib.modules) mkIf mkMerge;

  cfg = osConfig.swamp.security.bitwarden;
in
{
  config = mkIf cfg.enable (mkMerge [
    (mkIf cfg.sshAgent {
      home.sessionVariables.SSH_AUTH_SOCK = "${config.home.homeDirectory}/.bitwarden-ssh-agent.sock";
      # TODO: Git commit signing?
    })
    {
      home.packages = mkIf pkgs.stdenv.hostPlatform.isLinux [ pkgs.bitwarden-desktop ];
      programs.helium.extensions = [ "nngceckbapebfimnlniiiahkandclblb" ];
    }
  ]);
}
