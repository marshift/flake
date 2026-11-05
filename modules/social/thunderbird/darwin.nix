{
  lib,
  config,
  ...
}:
lib.modules.mkIf config.swamp.social.thunderbird.enable {
  homebrew.casks = [ "thunderbird" ];
}
