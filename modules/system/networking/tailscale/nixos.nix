{
  lib,
  config,
  ...
}:
let
  inherit (config.services) tailscale;
in
lib.modules.mkIf config.swamp.system.networking.tailscale.enable {
  networking.firewall = {
    trustedInterfaces = [ "${tailscale.interfaceName}" ];
    checkReversePath = "loose";

    allowedUDPPorts = [ tailscale.port ];
  };

  services.tailscale = {
    enable = true;
    permitCertUid = "root";
  };
}
