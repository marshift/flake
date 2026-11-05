{
  lib,
  config,
  ...
}:
lib.modules.mkIf config.swamp.media.obs.enable {
  homebrew.casks = [ "obs" ];
}
