{
  lib,
  config,
  ...
}:
lib.modules.mkIf config.swamp.media.vlc.enable {
  homebrew.casks = [ "vlc" ];
}
