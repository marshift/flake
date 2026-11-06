{
  lib,
  config,
  ...
}:
lib.modules.mkIf config.swamp.social.fluxer.enable {
  homebrew.casks = [ "fluxer" ];
}
