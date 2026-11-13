{
  lib,
  config,
  ...
}:
lib.modules.mkIf config.swamp.media.mpv.enable {
  homebrew.casks = [ "mpv" ];
}
