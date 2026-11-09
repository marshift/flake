{
  lib,
  pkgs,
  config,
  ...
}:
let
  inherit (lib.options) mkEnableOption mkOption;
in
{
  options.swamp.hardware.asahi = {
    enable = mkEnableOption "configuration for Asahi Linux";
    machineId = mkOption {
      type = lib.types.str;
      description = "The Mac's machine ID.";
    };
  };

  config.assertions = lib.modules.mkIf config.swamp.hardware.asahi.enable [
    {
      assertion = (pkgs.stdenv.hostPlatform.system == "aarch64-linux"); # Flimsy check but whatever
      message = "This module should only be imported on Asahi Linux.";
    }
  ];
}
