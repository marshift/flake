{
  lib,
  pkgs,
  config,
  ...
}:
lib.modules.mkIf config.swamp.desktop.portals.enable {
  services.gnome.gnome-keyring.enable = true;

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;

    extraPortals = with pkgs; [
      xdg-desktop-portal-gnome
      xdg-desktop-portal-gtk
    ];
    config.common = {
      default = [
        "gnome"
        "gtk"
      ];
      "org.freedesktop.impl.portal.Secret" = "gnome-keyring";
    };
  };
}
