{
  osConfig,
  ...
}:
{
  # TODO: Module load order means steam-config-nix is in modules/gaming/vr/vrchat, fix ASAP!
  programs.steam.config = {
    enable = osConfig.swamp.gaming.steam.enable;
    onSteamRunning = "close";
  };
}
