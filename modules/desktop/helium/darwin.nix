{
  lib,
  config,
  ...
}:
lib.modules.mkIf config.swamp.desktop.helium.enable {
  homebrew.casks = [ "helium-browser" ];
}
