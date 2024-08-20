{ ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    settings = {
      "$mod" = "SUPER";
      bind = [ "$mod, Return, exec, foot" ];
    };
  };
}
