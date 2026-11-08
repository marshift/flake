{
  lib,
  pkgs,
  config,
  ...
}:
let
  inherit (pkgs) vrcx;
in
lib.modules.mkIf config.swamp.gaming.vr.vrcx.enable {
  environment.systemPackages = [ vrcx ];
  programs.firejail.wrappedBinaries.vrcx = {
    executable = lib.meta.getExe' vrcx "vrcx";
    profile = ./firejail.profile;
  };
}
