{
  lib,
  pkgs,
  config,
  ...
}:
{
  programs.zsh.enable = true;
  users.users = lib.attrsets.genAttrs config.swamp.users.users (name: {
    shell = pkgs.zsh;
  });
}
