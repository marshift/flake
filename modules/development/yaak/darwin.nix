{
  lib,
  config,
  ...
}:
lib.modules.mkIf config.swamp.development.yaak.enable {
  homebrew.casks = [ "yaak" ];
}
