# TODO: Tailscale CLI?
# https://tailscale.com/docs/reference/tailscale-cli?tab=macos
{
  lib,
  config,
  ...
}:
lib.modules.mkIf config.swamp.system.networking.tailscale.enable {
  homebrew.casks = [ "tailscale-app" ];
}
