{
  lib,
  config,
  ...
}:
let
  inherit (lib.options) mkOption;
  inherit (lib.types) enum listOf str;
  cfg = config.swamp.users;
in
{
  options.swamp.users = {
    users = mkOption {
      type = listOf str;
      description = "All users that will use this system.";
    };

    primaryUser = mkOption {
      type = enum cfg.users;
      description = "The primary user that will use this system.";
      default = lib.lists.head cfg.users;
    };
  };
}
