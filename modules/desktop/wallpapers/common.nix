{
  self,
  lib,
  config,
  ...
}:
let
  inherit (lib.options) mkOption;
  inherit (lib.types)
    enum
    listOf
    attrsOf
    path
    int
    ;
in
{
  options.swamp.desktop.wallpapers = {
    enable = self.lib.options.mkEnableOptionWithDefault "the cycling of wallpapers" config.swamp.desktop.enable;

    pools = mkOption {
      type = attrsOf path;
      default = {
        shared = ./shared;
        marsh = ./marsh;
      };
    };

    activePools = mkOption {
      type = listOf (enum (lib.attrsets.attrNames config.swamp.desktop.wallpapers.pools));
      description = "The pools of wallpapers to cycle through.";
      default = [
        "shared"
        config.swamp.users.primaryUser
      ];
    };

    cycleInterval = mkOption {
      type = int;
      description = "The cycle interval in seconds.";
      default = 60 * 60;
    };
  };
}
