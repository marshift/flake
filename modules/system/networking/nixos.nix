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

  users.groups.networkmanager.members = config.swamp.users.users;
}
