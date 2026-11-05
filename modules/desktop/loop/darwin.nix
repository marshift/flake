{
  lib,
  config,
  ...
}:
lib.modules.mkIf config.swamp.desktop.loop.enable {
  homebrew.casks = [ "loop" ];
}
