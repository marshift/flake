{
  lib,
  config,
  ...
}:
{
  users.users = lib.attrsets.genAttrs config.swamp.users.users (name: {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "nix"
    ];
    home = "/home/${name}";
  });
}
