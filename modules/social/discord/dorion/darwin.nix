{
  inputs,
  lib,
  config,
  ...
}:
lib.modules.mkIf config.swamp.social.dorion.enable {
  homebrew = {
    taps."psharma04/homebrew-dorion" = inputs.homebrew-dorion;
    casks = [ "dorion" ];
  };
}
