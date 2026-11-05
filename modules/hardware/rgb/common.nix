{
  self,
  lib,
  pkgs,
  config,
  ...
}:
let
  inherit (lib.options) mkOption;
  inherit (lib.types)
    submodule
    nullOr
    str
    listOf
    ;

  resizableARGBZoneModule = submodule {
    options = {
      device = mkOption {
        type = str;
        description = "The device containing the zone.";
      };
      id = mkOption {
        type = str;
        description = "The zone's ID.";
      };
      size = mkOption {
        type = str;
        description = "The zone's size.";
      };
    };
  };
in
{
  options.swamp.hardware.rgb = {
    color = mkOption {
      type = nullOr str;
      default = null;
      description = "The color to set all connected RGB devices to.";
    };
    resizableARGBZones = mkOption {
      type = listOf resizableARGBZoneModule;
      default = [ ];
      description = "The device-specific zones and their sizes.";
    };
  };

  config.assertions = lib.modules.mkIf (config.swamp.hardware.rgb.color != null) [
    (self.lib.modules.assertIsLinux pkgs)
  ];
}
