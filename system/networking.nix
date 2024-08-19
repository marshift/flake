{ lib, ... }:

{
  networking = {
    nameservers = [ "9.9.9.9" ];
    useDHCP = lib.mkDefault true;
    networkmanager.enable = true;
  };
}
