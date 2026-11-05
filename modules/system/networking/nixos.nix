{
  config,
  ...
}:
{
  networking = {
    inherit (config.swamp.system.networking) nameservers;
    useDHCP = false;

    networkmanager = {
      enable = true;
      wifi.backend = "iwd";
    };
  };

  users.groups = {
    network.members = config.swamp.users.users; # TODO: Remove?
    networkmanager.members = config.swamp.users.users;
  };
}
