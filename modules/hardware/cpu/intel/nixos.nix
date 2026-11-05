{
  lib,
  config,
  ...
}:
lib.modules.mkIf config.swamp.hardware.cpu.intel.enable {
  hardware.cpu.intel.updateMicrocode = true;
  boot = {
    initrd.availableKernelModules = [ "vmd" ];
    kernelModules = [ "kvm-intel" ];
  };
}
