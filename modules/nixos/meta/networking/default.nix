{ config, lib, ... }:

lib.habitat.mkModule {
  inherit config;
  path = [ "nixos" "meta" "networking" ];
  default = true;
  output = {
    networking = {
      nameservers = [ "9.9.9.9" ];

      useDHCP = false;
      dhcpcd.enable = false;

      networkmanager = {
        enable = true;
        dns = "none";
      };
    };
  };
}
