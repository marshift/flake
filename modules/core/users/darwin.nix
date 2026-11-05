{
  lib,
  config,
  ...
}:
let
  cfg = config.swamp.users;
in
{
  users = {
    users = lib.attrsets.genAttrs cfg.users (name: {
      isHidden = false;
      home = "/Users/${name}";
    });
    knownGroups = cfg.users;
  };

  system = { inherit (cfg) primaryUser; };
}
