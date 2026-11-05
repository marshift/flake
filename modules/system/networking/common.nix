# TODO: Allow disabling networking completely?
{
  lib,
  ...
}:
let
  inherit (lib.types) listOf str;
in
{
  options.swamp.system.networking.nameservers = lib.options.mkOption {
    type = listOf str;
    default = [
      "9.9.9.10"
      "149.112.112.10"
      "2620:fe::10"
      "2620:fe::fe:10"
    ];
    description = "The nameservers to use when resolving domain names.";
  };
}
