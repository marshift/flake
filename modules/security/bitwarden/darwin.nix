{
  lib,
  config,
  ...
}:
lib.modules.mkIf config.swamp.security.bitwarden.enable {
  homebrew.casks = [ "bitwarden" ];
}
