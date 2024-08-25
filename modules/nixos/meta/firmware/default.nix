{ config, lib, ... }:

lib.habitat.mkModule {
  inherit config;
  path = [ "nixos" "meta" "firmware" ];
  default = true;
  output = {
    hardware.enableAllFirmware = true;
    services.fwupd.enable = true;
  };
}
