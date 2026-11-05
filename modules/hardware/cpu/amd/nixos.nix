{
  lib,
  config,
  ...
}:
lib.modules.mkIf config.swamp.hardware.cpu.amd.enable {
  hardware.cpu.amd.updateMicrocode = true;
  boot.kernelModules = [ "kvm-amd" ];
}
