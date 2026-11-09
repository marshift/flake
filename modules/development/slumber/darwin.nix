{
  lib,
  config,
  ...
}:
lib.modules.mkIf config.swamp.development.slumber.enable {
  homebrew.casks = [ "slumber" ];
}
