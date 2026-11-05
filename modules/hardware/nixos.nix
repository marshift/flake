{
  pkgs,
  ...
}:
{
  hardware = {
    firmware = [ pkgs.linux-firmware ];
    enableAllFirmware = true;
  };
}
