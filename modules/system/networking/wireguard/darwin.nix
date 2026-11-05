{
  lib,
  config,
  ...
}:
lib.modules.mkIf config.swamp.system.networking.wireguard.enable {
  homebrew.brews = [ "wireguard-tools" ];
}
