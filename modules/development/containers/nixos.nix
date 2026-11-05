{
  lib,
  config,
  ...
}:
lib.modules.mkIf config.swamp.development.containers.enable {
  virtualisation.docker.enable = true;
  users.groups.docker.members = config.swamp.users.users;
}
