{
  lib,
  pkgs,
  config,
  osConfig,
  ...
}:
let
  inherit (lib.modules) mkIf mkMerge;

  cfg = osConfig.swamp.security._1password;
in
{
  config = mkIf cfg.enable (mkMerge [
    (mkIf cfg.sshAgent {
      home.sessionVariables.SSH_AUTH_SOCK =
        if pkgs.stdenv.hostPlatform.isDarwin then
          "${config.home.homeDirectory}/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
        else
          "${config.home.homeDirectory}/.1password/agent.sock";

      programs.git.settings = {
        commit.gpgsign = true;
        gpg.format = "ssh";
        "gpg \"ssh\"".program = "${lib.getExe' pkgs._1password-gui "op-ssh-sign"}";
      };
    })
    {
      programs.helium.extensions = [ "aeblfdkhhhdcdjpifhhbdiojplfjncoa" ];
    }
  ]);
}
