{
  lib,
  config,
  ...
}:
lib.modules.mkIf config.swamp.security._1password.enable {
  homebrew.casks = [ "1password" ];
}
