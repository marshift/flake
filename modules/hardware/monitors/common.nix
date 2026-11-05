{
  lib,
  ...
}:
let
  inherit (lib.types)
    submodule
    str
    nullOr
    float
    listOf
    ;
  inherit (lib.options) mkOption;

  monitorModule = submodule {
    options = {
      criteria = mkOption {
        type = str;
        description = "The monitor's criteria (identifier).";
      };

      mode = mkOption {
        type = str;
        default = "1920x1080@144Hz";
        description = "The monitor's resolution mode.";
      };

      position = mkOption {
        type = nullOr str;
        default = null;
        description = "The monitor's position in the global coordinates space.";
      };

      scale = mkOption {
        type = float;
        default = 1.0;
        description = "The monitor's scale factor.";
      };
    };
  };
in
{
  options.swamp.hardware.monitors = mkOption {
    type = listOf monitorModule;
    default = [ ];
    description = "The monitors attached to the system.";
  };
}
