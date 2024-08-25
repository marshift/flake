{ config, lib, ... }:

lib.habitat.mkModule {
  inherit config;
  path = [ "nixos" "services" "fwupd" ];
  default = true;
  output = {
    hardware.enableAllFirmware = true;
    services.fwupd.enable = true;
  };
}
