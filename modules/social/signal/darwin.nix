{
  lib,
  config,
  ...
}:
lib.modules.mkIf config.swamp.social.signal.enable {
  homebrew.casks = [ "signal" ];
}
