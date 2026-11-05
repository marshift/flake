{
  lib,
  config,
  ...
}:
let
  inherit (lib.modules) mkIf;
in
mkIf config.swamp.desktop.audio.enable {
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;

    alsa = {
      enable = true;
      support32Bit = true;
    };

    pulse.enable = true;

    wireplumber = {
      enable = true;
      extraConfig."10-bluez" = mkIf config.swamp.hardware.bluetooth.enable {
        "monitor.bluez.properties" = {
          "bluez5.enable-sbc-xq" = true;
          "bluez5.enable-msbc" = true;
          "bluez5.enable-hw-volume" = true;
        };
      };
    };
  };
}
