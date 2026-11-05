{
  lib,
  config,
  ...
}:
lib.modules.mkIf config.swamp.desktop.ghostty.enable {
  homebrew.casks = [ "ghostty" ];
}
