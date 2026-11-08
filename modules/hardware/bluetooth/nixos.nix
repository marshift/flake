{
  lib,
  config,
  ...
}:
lib.modules.mkIf config.swamp.hardware.bluetooth.enable {
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
  };
}
