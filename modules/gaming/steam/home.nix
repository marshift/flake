{
  osConfig,
  ...
}:
{
  # TODO: Module load order means steam-config-nix is in modules/gaming/vr/vrchat, fix!
  programs.steam.config = {
    enable = osConfig.swamp.gaming.steam.enable;
    onSteamRunning = "close";

    desktopEntries.enable = true;
  };
}
