{
  lib,
  config,
  ...
}:
lib.modules.mkIf config.swamp.development.impactor.enable {
  homebrew.casks = [ "impactor" ];
}
