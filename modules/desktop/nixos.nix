{
  lib,
  config,
  ...
}:
lib.modules.mkIf config.swamp.desktop.enable {
  environment.variables = {
    DISPLAY = ":0";
    NIXOS_OZONE_WL = "1";
    XDG_SESSION_TYPE = "wayland";
    SDL_VIDEODRIVER = "wayland";
    SDL_VIDEO_DRIVER = "wayland";
    CLUTTER_BACKEND = "wayland";
    GDK_BACKEND = "wayland";
    WLR_BACKEND = "vulkan";
  };
}
