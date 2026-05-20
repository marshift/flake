{
  boot.initrd = {
    luks.devices."cryptroot".device = "/dev/disk/by-label/NIXOS_LUKS";
    kernelModules = [ "dm-snapshot" "cryptd" ];
  };
}
