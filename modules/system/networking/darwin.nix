{
  config,
  ...
}:
{
  networking = {
    dns = config.swamp.system.networking.nameservers;
    knownNetworkServices = [
      "Wi-Fi"
      # TODO: Ethernet! It's different per-Mac, see networksetup -listallnetworkservices
    ];
  };
}
