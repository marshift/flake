{
  lib,
  pkgs,
  config,
  ...
}:
lib.modules.mkIf config.swamp.system.networking.wireguard.enable {
  environment.systemPackages = with pkgs; [
    wireguard-tools
    openresolv
  ];
}
