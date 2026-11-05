{
  lib,
}:
let
  mkEnableOptionWithDefault =
    name: default:
    lib.options.mkOption {
      inherit default;
      type = lib.types.bool;
      description = "Whether to enable ${name}.";
    };
in
{
  inherit mkEnableOptionWithDefault;
}
