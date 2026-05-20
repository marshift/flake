{
  lib,
  inputs,
  ...
}: {
  imports = [
    inputs.nixos-apple-silicon.nixosModules.apple-silicon-support
  ];

  boot.loader.efi.canTouchEfiVariables = lib.mkForce false; # Please don't break my macOS install.
}
