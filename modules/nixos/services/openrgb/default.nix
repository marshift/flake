{ config, lib, ... }:

lib.habitat.mkModule {
  inherit config;
  path = [ "nixos" "services" "openrgb" ];
  output = {
    services.hardware.openrgb.enable = true;
  };
}
