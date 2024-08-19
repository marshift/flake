{ lib, ... }:

{
  networking = {
    nameservers = [ "9.9.9.9" ];

    useDHCP = false;
    dhcpcd.enable = false;

    networkmanager = {
      enable = true;
      dns = "none";
    };
  };
}
