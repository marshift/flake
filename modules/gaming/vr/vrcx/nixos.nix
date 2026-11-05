{
  lib,
  pkgs,
  config,
  ...
}:
let
  inherit (lib.modules) mkIf;

  enabled = config.swamp.gaming.vr.vrcx.enable;
  shouldFirejail = enabled && config.swamp.security.firejail.enable;
in
{
  environment.systemPackages = mkIf enabled [ pkgs.vrcx ];

  programs.firejail.wrappedBinaries.vrcx = mkIf shouldFirejail {
    executable = "${pkgs.vrcx}/bin/vrcx";
    profile = ./firejail.profile;
  };
}
